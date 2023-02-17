import os
import subprocess
from modules.logging import log

"""
  configure docker to run without requiring root access
"""


class DockerManager:
    username: str

    def __init__(self) -> None:
        self.username = self.get_username()

    def get_username(self) -> str:
        user: str | None = os.getenv("USER")
        if not user:
            raise Exception("failed to get $USER from environment")

        return user

    def create_docker_group(self) -> None:
        log("creating docker usergroup")
        subprocess.run(["sudo", "groupadd", "docker"])

    def add_user_to_docker_group(self) -> None:
        log("adding user to docker usergroup")
        subprocess.run(["sudo", "usermod", "-aG", "docker", self.username])
