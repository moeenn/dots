#! /bin/lua

function exit(message)
    io.stderr.write("error: " .. message .. ".\n")
    os.exit(1)
end

function exec(cmd)
    local status = os.execute(cmd)
    return status == true
end

function collect_packages(pkgs)
   local pkg_str = ""
   for _, pkg in ipairs(pkgs) do
       pkg_str = pkg_str .. " " .. pkg
   end
   return pkg_str
end

function pkgs_install(pkgs)
	local cmd = "sudo apt-get install -y" .. collect_packages(pkgs)
	return exec(cmd)
end

function pkgs_uninstall(pkgs)
    local cmd = "sudo apt-get remove" .. collect_packages(pkgs)
    return exec(cmd)
end

function process_cmd(cmd, pkgs)
	if cmd == nil then
    		cmd = "install"
	end

	if cmd == "install" then
	    	return pkgs_install(pkgs)
	elseif cmd == "uninstall" then
    		return pkgs_uninstall(pkgs)
	else
		exit("invalid command")
	end
end

function main()
	local cmd = arg[1]
	local version = "20"
	local gcc_version = "15"
	
	local pkgs = {
    	"llvm-" .. version,
		"clang",
		"clangd",
		"clang-format",
		"clang-" .. version,
		"clangd-" .. version,
		"clang-format-" .. version,
		"gcc-" .. gcc_version,
		"bear",
		"cmake",
		"valgrind"
	}

	process_cmd(cmd, pkgs)
end

main()
