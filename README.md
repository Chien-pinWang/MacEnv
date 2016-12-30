# Work Environment Settings

This directory holds some critical settings of my Mac OS environment.

## Installation

- `git clone` this project to the ~/.env directory
- `ln -s ~/.env/.bash_profile ~/.bash_profile` to setup bash environment
- `ln -s ~/.env/.vim_runtime ~/.vim_runtime; ln -s ~/.vim_runtime/.vimrc ~/.vimrc` to setup vim and its dependencies
- `ln -s ~/.env/.gitconfig ~/.gitconfig` to setup git configurations
- `ln -s ~/.env/gitup.sh ~/bin/gitup.sh` to make gitup.sh in PATH.
- Optionally, Add this line `30 11 * * 2,5 /Users/cpw/bin/gitup.sh` to your cron table through `crontab -e` to sync any updates to remote repository

## Usage

- At command prompt, type `alias` to see all aliased commands.
- When setting is changed, run gitup.sh to keep settings in git

## To-do's



## Contributing

This is a personal project.

## History

- 12/28/2016 Initial release with configs of the bash shell and vim.

## Credits


## License
