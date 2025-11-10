#! /bin/lua

function exec(cmd)
    local s = os.execute(cmd)
    return s == true
end


function exit(message)
   io.stderr:write("error: " .. message .. ".\n")
   os.exit(1)
end


function collect_args()
	local s = ""
	for _, a in arg 
end


function pkg_search(pkg_name)
    return exec("apt-cache search " .. pkg_name)
end


function pkg_install(pkgs)

end

function process_cmd(cmd)
	if cmd == nil then
    	exit("please provide a valid command")
	end

	
end


function main()
	local cmd = arg[1]
	process_cmd(cmd)
end


main()
