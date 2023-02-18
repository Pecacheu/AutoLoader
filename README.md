# Node.js AutoLoader
## Automagically run Node programs on any system!

Originally developed long ago back in 2012 when I was just a kid, AutoLoader is a simple, yet continually evolving program I use to install Node.js on the target system and load all required resources before launching a program.

You see, the main issue with `npm` is that it has to be installed already to use it! This is a bit of an issue for non-tech savvy users or those who've never used Node before trying to run your program... *"Command not found? What?"*

This loader preforms the following:
- Checks that Node.js is installed and the current version is new enough.
- Changes the CWD (Current Working Directory) to the script path for installation.
- Removes any outdated install, then automagically fetches and installs the latest version.
- If native packages are required, node-gyp is installed, along with Python and other dependencies.
- *Windows only:* If VS is not installed, the user is given a guided install for Visual Studio Build Tools. (This has been automated as much as possible, but they may need to hit a confirm button or two. The correct optional packages have already been checked.)
- Launches the Nodejs-side of the loader.
- Installs all required packages.
- Fetches HTTP/HTTPS dependencies and drops them wherever you like.
- Changes the CWD back, so that your code will see it as normal.
- Reads info about the system configuration.
- *And last but not least...* Launches your super awesome code!

## Adding to your project

To add AutoLoader to your project, cd to it and run `git subtree -P AutoLoader add https://github.com/Pecacheu/AutoLoader main --squash`

Then, on Linux run `ln -s AutoLoader/run.sh run.sh; ln -s AutoLoader/run.exe run.exe`\
Or on Windows (as Admin) run `mklink run.sh AutoLoader\run.sh & mklink run.exe AutoLoader\run.exe`

Be sure to create a `load.js` file in your root directory, to configure AutoLoader! You may add your npm dependencies to `package.json` as usual, that will take priority, or you can forgo a `package.json` altogether and specify your packages in `load.js`, in which case your `package.json` is autogenerated. All packages will be installed locally, except for node-gyp, which is installed globally.

## Usage

The configuration is stored in `../load.js`. Included is an example config with descriptions of the available options. When all dependencies are loaded, `main()` is called with one parameter, info. It contains the following:

- `ips` An Array of all external IPs on this system.
- `dir` Absolute path to your project's root directory.
- `os` OS, ex. `Windows`, `Linux`, or `MacOS`
- `arch` CPU Arch, ex. `32-bit`, `64-bit`, or `ARM`
- `cpu` CPU name, ex. `Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz`
- `cpus` CPU thread count.

Command line arguments are passed to your script with `process.argv` as normal. However, if the script is called with the argument `.reload`, all dependencies will be deleted and reloaded! The slightly odd name was chosen to avoid conflicts.

### Windows and Linux (Ubuntu, Raspbian, Debian, Arch, Android Termux, etc.) supported!

MacOS support coming eventually, when I get around to it. (Tho honestly as a former user, screw the modern post-Steve(s) Apple and their anti-Open Source, Consumer Data-selling walled garden. Yeesh, at least 2020s Microsoft *pretends* to care about GNU.)