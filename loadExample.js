//AutoLoader Example Config

exports.opts = {
	debug:false, //<- Debug Mode Enable
	minVer:19, //<- Min Node.js Version
	deleteDir:false, //<- Delete Entire Module Directory and Reinstall if Incomplete
	autoInstOptional:true, //<- Also Install Optional Packages During Required Package Installation
	npmInstNames:["chalk", "pg"], //<- Dependencies List
	optionalInst:["serialport"], //<- Optional Dependencies
	wgetFiles:["https://forestfire.net/resources/RoruEggs.png"], //<- Optional Site Resources
	wgetPath:"/test" //<- Resource Download Location
}

exports.main = async info => {
	const chalk = (await import('chalk')).default;
	console.log(chalk.gray("All Dependencies Found!\n"));
	//(await import('./main.js')).begin(info); //Example of script loading
}