#Nodejs AutoLoader, 2023 Pecacheu. GNU GPL v3.0
if(!($DIR=$PSScriptRoot)) {$DIR=Split-Path -Parent ([Environment]::GetCommandLineArgs()[0])}
cd $DIR/..
if($host.version.major -ge 6) {$e="`e[31m";$r="`e[0m"} else {$e=$r=""}
$minVer=(Select-String "minVer.+?(\d+)" load.js).Matches.Groups[1].Value
function getVer {((node -v) | Select-String "\d+").Matches.Value}

#Check version
if(Get-Command npm 2>$null) {
	$node=getVer; if($node -lt $minVer) {
		"${e}Node v$node is too old! You must have >= $minVer$r"
		Uninstall-Package -Name "Node.js"
		if(Get-Command npm 2>$null) {"${e}Uh oh, uninstall failed!$r"; pause; exit}
		$inst=1
	}
} else {$inst=1}

#Install Node
if($inst) {
	winget install OpenJS.NodeJS; $node=getVer
	if($node -lt $minVer) {"${e}New version v$node is too old!?$r"; pause; exit}
}
node $DIR/run.mjs $args
if($LastExitCode) {pause}