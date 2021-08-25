const {exec} = require("child_process")

/** parse command line flags as an object literal */
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

/** execute a command on the system asynchronously */
function execute(command) {
	return new Promise((resolve, reject) => {
		exec(command, (err, stdOut, stdErr) => {
			if (err) reject(err)
				if (stdErr) reject(stdErr)
					resolve(stdOut)
		})
	})
}

module.exports = {
	parseArgs,
	execute,
}
