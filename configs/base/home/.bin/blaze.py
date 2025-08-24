#!/usr/bin/python3

from dataclasses import asdict, dataclass
from enum import StrEnum
import os
import json
from typing import Any
import io
import subprocess
import time
from datetime import datetime


class CppStandard(StrEnum):
    TwentyThree = "gnu++23"

    @staticmethod
    def from_string(raw: str):
        match raw:
            case "gnu++23":
                return CppStandard.TwentyThree

        # TODO: add more.
        raise Exception(f"Unrecognized C++ standard: {raw}")


@dataclass
class CompileCommandOptions:
    compiler: str
    std: CppStandard
    flags: str
    includes: list[str]
    input_file: str
    output_object: str
    optimization: int = 3
    is_release: bool = False

    def to_string(self) -> str:
        builder = io.StringIO()
        builder.write(self.compiler + " ")
        for inc in self.includes:
            builder.write(f"-I{inc} ")

        builder.write(f"-O{self.optimization} ")
        if self.is_release:
            builder.write("-DNDEBUG ")

        builder.write(f"-std={str(self.std)} ")
        builder.write(f"{self.flags} ")
        builder.write(f"-o {self.output_object} ")
        builder.write(f"-c {self.input_file}")
        return builder.getvalue()


@dataclass
class CompileCommand:
    directory: str
    command: CompileCommandOptions
    file: str
    output: str


@dataclass
class ProjectFile:
    name: str
    compiler: str
    std: CppStandard
    flags: str


class SourceManager:
    current_dir: str
    source_extensions: list[str] = ["cpp"]
    header_extensions: list[str] = ["h", "hpp"]

    def __init__(self, current_dir: str) -> None:
        self.current_dir = current_dir

    def is_source_file(self, filename: str) -> bool:
        for ext in self.source_extensions:
            if filename.endswith("." + ext):
                return True
        return False

    def is_header_file(self, filename: str) -> bool:
        for ext in self.header_extensions:
            if filename.endswith("." + ext):
                return True
        return False

    def discover_source_files(self) -> list[str]:
        file_paths = []
        for root, _, files in os.walk(self.current_dir):
            for file in files:
                if self.is_source_file(file):
                    file_paths.append(os.path.join(root, file))
        return file_paths

    def discover_include_directories(self) -> list[str]:
        dir_paths: set[str] = set()
        for root, _, files in os.walk(self.current_dir):
            for file in files:
                if self.is_header_file(file):
                    dir = os.path.join(root, os.path.dirname(file))
                    dir_paths.add(dir)
        return list(dir_paths)


class ObjectManager:
    current_dir: str
    cache_dir: str = ".cache"

    def __init__(self, current_dir: str) -> None:
        self.current_dir = current_dir
        self.validate_or_create_cache_dir()

    def validate_or_create_cache_dir(self) -> None:
        full_path = os.path.join(self.current_dir, self.cache_dir, "objects")
        if not os.path.exists(full_path):
            try:
                os.makedirs(full_path)
            except Exception as ex:
                raise Exception(f"could not create cache directory: {str(ex)}.")

        if not os.path.isdir(full_path):
            raise Exception("Cache objects path is not a directory.")

    def get_object_file_path(self, source_file_path: str) -> str:
        object_dir_path = os.path.join(self.current_dir, self.cache_dir, "objects")

        source_file_path = source_file_path.removeprefix(self.current_dir)
        if source_file_path.startswith("/"):
            source_file_path = source_file_path.removeprefix("/")

        filename = source_file_path.replace("/", "_")
        file_path = os.path.join(object_dir_path, filename)
        return file_path + ".o"


class ProjectFileManager:
    project_file_name: str = "project.json"
    current_dir: str
    default_flags: str = "-Wextra -Werror -Wall -Wpedantic"

    def __init__(self, current_dir: str) -> None:
        self.current_dir = current_dir

    def __is_project_dir(self) -> bool:
        current_dir_files = os.listdir(self.current_dir)
        for file in current_dir_files:
            if file == self.project_file_name:
                return True

        return False

    def get_default_project_file(self) -> ProjectFile:
        return ProjectFile(
            name="sandbox",
            compiler="/bin/clang++",
            std=CppStandard.TwentyThree,
            flags=self.default_flags,
        )

    # TODO: test me.
    def write_default_project_file(self, target_dir: str) -> None:
        full_path = os.path.join(target_dir, self.project_file_name)
        if os.path.exists(full_path):
            raise Exception(f"{self.project_file_name} file already exists.")

        default_project_file_content = self.get_default_project_file()
        json_content = json.dumps(asdict(default_project_file_content))

        with open(full_path, "wt") as project_file:
            project_file.write(json_content)

    def read_project_file(self) -> ProjectFile:
        is_project_dir = self.__is_project_dir()
        if not is_project_dir:
            raise Exception("Current directory is not a C++ project.")

        full_path = os.path.join(self.current_dir, self.project_file_name)
        with open(full_path) as project_file:
            try:
                content = json.load(project_file)
            except Exception as ex:
                raise Exception(
                    f"{self.project_file_name} file does not contain valid json: {str(ex)}"
                )

            name = self.read_and_validate_name(content)
            compiler = self.read_and_validate_compiler(content)
            std = self.read_and_validate_std(content)
            flags = self.read_and_validate_flags(content)
            return ProjectFile(name=name, compiler=compiler, std=std, flags=flags)

    def read_and_validate_name(self, content: Any) -> str:
        if "name" not in content:
            raise Exception(f"'name' option missing in file {self.project_file_name}")

        name = content["name"]
        if not isinstance(name, str):
            raise Exception(
                f"Invalid 'name' value in file {self.project_file_name}: value is not a string"
            )

        return name

    def read_and_validate_compiler(self, content: Any) -> str:
        if "compiler" not in content:
            raise Exception(
                f"'compiler' option missing in file {self.project_file_name}."
            )

        compiler = content["compiler"]
        if not isinstance(compiler, str):
            raise Exception(
                f"Invalid 'compiler' value in {self.project_file_name}: value is not a string."
            )

        if not os.path.exists(compiler):
            raise Exception(
                f"Invalid 'compiler' option in {self.project_file_name}: {compiler} not found."
            )

        return compiler

    def read_and_validate_std(self, content: Any) -> CppStandard:
        if "std" not in content:
            raise Exception(f"'std' option missing in file {self.project_file_name}.")

        std_raw = content["std"]
        if not isinstance(std_raw, str):
            raise Exception(
                f"Invalid 'std' value in {self.project_file_name}: value is not a string."
            )
        return CppStandard.from_string(std_raw)

    def read_and_validate_flags(self, content: Any) -> str:
        if "flags" not in content:
            return self.default_flags

        flags = content["flags"]
        if not isinstance(flags, str):
            raise Exception(
                f"Invalid 'flags' value in {self.project_file_name}: value is not a string."
            )
        return f"{self.default_flags} {flags.strip()}"


class ProjectManager:
    __slots__ = ["project_file", "source_manager", "object_manager"]

    project_file: ProjectFile
    source_manager: SourceManager
    object_manager: ObjectManager

    def __init__(
        self,
        project_file_manager: ProjectFileManager,
        source_manager: SourceManager,
        object_manager: ObjectManager,
    ) -> None:
        self.project_file = project_file_manager.read_project_file()
        self.source_manager = source_manager
        self.object_manager = object_manager

    def __get_compile_commands(self) -> list[CompileCommand]:
        current_dir = self.source_manager.current_dir
        include_dirs = self.source_manager.discover_include_directories()

        commands = []
        source_files = self.source_manager.discover_source_files()
        if not source_files:
            raise Exception("No source files found.")

        for source_file in source_files:
            object_file_path = self.object_manager.get_object_file_path(source_file)
            file_command = CompileCommand(
                directory=current_dir,
                file=os.path.join(current_dir, source_file),
                output=object_file_path,
                command=CompileCommandOptions(
                    compiler=self.project_file.compiler,
                    std=self.project_file.std,
                    flags=self.project_file.flags,
                    input_file=source_file,
                    output_object=object_file_path,
                    includes=include_dirs,
                ),
            )
            commands.append(file_command)

        return commands

    def build(self) -> None:
        compile_commands = self.__get_compile_commands()
        self.dump_compile_commands(compile_commands)

        last_build_ts = self.__read_last_build_timestamp()
        self.__build_objects(compile_commands, last_build_ts)

        final_cmd = self.__get_final_build_cmd(compile_commands)
        print(final_cmd)
        subprocess.run(final_cmd.split(" "))
        self.__dump_last_build_timestamp()

    def __build_objects(
        self, compile_commands: list[CompileCommand], last_build: datetime | None
    ) -> None:
        for cmd in compile_commands:
            if last_build is not None:
                file_modification_date = os.path.getmtime(cmd.command.input_file)
                if (
                    os.path.exists(cmd.command.output_object)
                    and file_modification_date <= last_build.timestamp()
                ):
                    continue

            as_string = cmd.command.to_string()
            print(as_string)
            subprocess.run(as_string.split(" "))

    def __get_final_build_cmd(self, compile_commands: list[CompileCommand]) -> str:
        builder = io.StringIO()
        builder.write(f"{compile_commands[0].command.compiler} ")
        for cmd in compile_commands:
            builder.write(f"{cmd.command.output_object} ")

        builder.write(f"-o {self.project_file.name}")
        return builder.getvalue()

    def __dump_last_build_timestamp(self) -> None:
        timestamp_filepath = os.path.join(
            self.object_manager.current_dir, ".cache", "last_build.txt"
        )
        current_timestamp = time.time()
        with open(timestamp_filepath, "w") as file:
            file.write(str(current_timestamp))

    def __read_last_build_timestamp(self) -> datetime | None:
        timestamp_filepath = os.path.join(
            self.object_manager.current_dir, ".cache", "last_build.txt"
        )
        if not os.path.exists(timestamp_filepath):
            return None

        with open(timestamp_filepath, "r") as file:
            raw_content = file.read()
            try:
                as_float = float(raw_content.strip())
            except Exception:
                return None

        return datetime.fromtimestamp(as_float)

    def dump_compile_commands(self, compile_commands: list[CompileCommand]) -> None:
        normalized = []
        for cmd in compile_commands:
            as_dict = asdict(cmd)
            as_dict["command"] = cmd.command.to_string()
            normalized.append(as_dict)

        compile_cmds_path = os.path.join(
            self.object_manager.current_dir, "compile_commands.json"
        )
        if os.path.exists(compile_cmds_path):
            os.remove(compile_cmds_path)

        with open(compile_cmds_path, "wt") as output:
            json.dump(normalized, output, indent=True)


def main() -> None:
    current_dir = os.getcwd()
    projectf_manager = ProjectFileManager(current_dir)
    source_manager = SourceManager(current_dir)
    object_manager = ObjectManager(current_dir)

    project_manager = ProjectManager(
        project_file_manager=projectf_manager,
        source_manager=source_manager,
        object_manager=object_manager,
    )

    project_manager.build()


"""
# TODO

- [ ] Initialize new projects.
- [ ] Allow building in release mode.
- [ ] Allow building object files in parallel.
- [ ] Allow building files from nested source directories.
        
"""

if __name__ == "__main__":
    try:
        main()
    except Exception as ex:
        print("error: " + str(ex))
