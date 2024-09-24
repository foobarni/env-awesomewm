# Have a new Arch Linux installation?

*...in progress*

These tools will settle the environment to accommodate my
[AwesomeWM dotfiles](https://github.com/foobarni/dotfiles-awesomewm).

# Logging

The current version installs packages only from the official repositories.
It accepts arguments and prints an error if no arguments are specified.

Need to:
 - [ ] Have some default packages to be installed if no arguments are given.
 - [ ] Integrate packages built from source, such as `ctpv`.
 - [ ] Take notes of all the packages that are not included in a base Arch Linux
install.

# Usage

Clone this repository and cd into its directory:

```
$ git clone https://github.com/foobarni/env-awesomewm.git 
$ cd env-awesomewm
```

Make the script executable:

```
$ chmod u+x settle.sh
```

Run the script and specify the package categories you wish to install following
the `-c` or `--category` flags:
 - appearance
 - virtualization
 - essential_utils
 - networking
 - system_tools
 - dev_tools
 - multimedia

 ```
# ./settle.sh -c appearance virtualization
 ```

 You can also install all packages using `-a` or `--all`:

 ```
# ./settle.sh --all
# ./settle.sh -a
 ```
