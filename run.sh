#!/bin/bash
#Nodejs AutoLoader v3.6, 2023 Pecacheu. GNU GPL v3
e="\x1b[31m"; r="\x1b[0m"
DIR="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"; cd "$DIR/.."
minVer=$(grep -Eo "minVer.+?[0-9]+" load.js | grep -Eo "[0-9]+" | head -1)
getVer() {
	node=$(node -v | grep -Eo "[0-9]+" | head -1)
}

#Check version
if type npm &>/dev/null; then
	getVer; if [[ $node < $minVer ]]; then
		echo -e "${e}Node v$node is too old! You must have >= $minVer$r"
		if type snap; then sudo snap remove node; fi; inst=1
	fi
else inst=1; fi

#Install Node
if [ $inst ]; then
	set -e
	if type apt; then sudo apt install nodejs -y
	elif type pkg; then pkg install nodejs
	elif type pacman; then pacman -S install nodejs
	else echo -e "${e}Sorry, your package manager is not supported.$r"; exit; fi
	npm i -g n; sudo n latest; sudo n prune; getVer
	if [[ $node < $minVer ]]; then
		echo -e "${e}New version v$node is too old!?$r"; exit
	fi
fi
node "$DIR/run.mjs" $@