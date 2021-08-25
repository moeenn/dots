const fs = require("fs")
const {exec} = require("child_process")
const log = console.log

async function main(args) {
	const parsedArgs = parseArgs(args)

	/** print help message when appropriate */
	if (parsedArgs["-h"] || !parsedArgs["-c"] || !parsedArgs["-b"]) {
		printHelp()
		return
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
	]

	try {
		await runCommands(commands, execute)
	} catch(error) {
		log(error)
	}
}

main(process.argv)

function parseArgs(args) {
	const result = {}

	for (const arg of args) {
		const isFlag = arg.startsWith("-")

		if (isFlag) {
			const flagIndex = args.indexOf(arg)
			result[arg] = args[flagIndex + 1]
		}
	}

	return result
}

function execute(command) {
	return new Promise((resolve, reject) => {
		exec(command, (err, stdOut, stdErr) => {
			if (err) reject(err)
			if (stdErr) reject(stdErr)
			resolve(stdOut)
		})
	})
}

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
	const sepa = "\n____________________________________________________\n"
	for (const command of commands) {
		log("Command: ", command, sepa)
		const result = await executor(command).catch(error => {
			throw error
		})
		
		log(result, "\n")
	}
}
