const fs = require("fs")
const {execute, parseArgs} = require("./common/utils.js")
const log = console.log

async function main(args) {
	const parsedArgs = parseArgs(args)

	/** print help message when appropriate */
	if (parsedArgs["-h"] || !parsedArgs["-c"]) {
		printHelp()
		return
	}

	if (!parsedArgs["-b"]) {
		parsedArgs["-b"] = "main"
	}

	const isRepo = await isGitRepo()
	if (!isRepo) {
		log("[Error] Current directory is not a git repository")
		return
	}

	const commands = [
		"git add .",
		`git commit -m "${ parsedArgs['-c']}"`,
		`git push origin ${ parsedArgs['-b']}`,
		'git status',
	]

	/** 
	 *  since output of all commands is already shown, we can
   *  ignore any exceptions thrown 
	 */
	try {
		await runCommands(commands, execute)
	} catch (_) {}
}

main(process.argv)

function printHelp() {
	log("Usage:\t[script] -c [Commit Message] -b [Git Branch] -h [Print Help]")
}

async function isGitRepo() {
	const pwd = await execute("pwd")
	const target = pwd.trim() + "/.git"
	log(target)
	return fs.existsSync(target)
}

async function runCommands(commands, executor) {
	const sepa = "\n____________________________________________________"
	for (const command of commands) {
		log("Command: ", command, sepa)
		const result = await executor(command).catch(error => {
			throw error
		})
		
		log(result, "\n")
	}
}
