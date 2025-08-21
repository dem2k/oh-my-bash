# ⚠️ Important Notice ⚠️

This repository is **not the official version** of the original project. It has been heavily modified and adapted for my personal use cases.  

If you are looking for the **official repository**, please visit: https://github.com/ohmybash/oh-my-bash

Do **not** report issues or pull requests here that are intended for the official project.  

## Basic Installation

Oh My Bash is installed by running one of the following commands in your terminal.

### via curl

```shell
bash -c "$(curl -fsSL https://raw.githubusercontent.com/dem2k/oh-my-bash/master/tools/install.sh)"
```

### via wget

```shell
bash -c "$(wget https://raw.githubusercontent.com/dem2k/oh-my-bash/master/tools/install.sh -O -)"
```

This replaces `~/.bashrc` with the version provided by Oh My Bash. The original `.bashrc` is backed up with the name `~/.bashrc.omb-TIMESTAMP`.

If `~/.bash_profile` does not exist, this also creates a new file `~/.bash_profile` with the default contents.

If `~/.bash_profile` already existed before Oh My Bash is installed, please make sure that`~/.bash_profile` contains the line `source ~/.bashrc`.
