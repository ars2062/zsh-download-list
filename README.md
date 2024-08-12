# zsh-download-list

[![Author](https://img.shields.io/badge/Author-ars2062-b68469.svg?style=flat-square)](https://yourwebsite.com)
[![License](https://img.shields.io/github/license/ars2062/zsh-download-list.svg?style=flat-square)](./LICENSE)

A simple [`oh-my-zsh`](https://ohmyz.sh/) plugin to facilitate bulk downloading of files using `axel`, a lightweight command-line download accelerator.

## Installation

### oh-my-zsh

First, clone this repository into the `oh-my-zsh` plugins directory:

```bash
git clone https://github.com/ars2062/zsh-download-list.git ~/.oh-my-zsh/custom/plugins/download-list
```

Next, activate the plugin in your `~/.zshrc` file by adding `download-list` to the [plugins array](https://github.com/robbyrussell/oh-my-zsh/blob/master/templates/zshrc.zsh-template#L66).

```bash
plugins=(
    [other plugins...]
    download-list
)
```

After saving the changes to your `~/.zshrc`, run the following command to apply the changes:

```bash
source ~/.zshrc
```

## Usage

### `download-list`

The `download-list` function allows you to download multiple files concurrently using `axel`. 

#### Syntax

```bash
download-list <file_with_links> [num_threads]
```

- `<file_with_links>`: Path to the file containing the list of URLs to download, one per line.
- `[num_threads]`: Optional. Number of threads to use for each download (default is 4).

#### Example

```bash
download-list mylinks.txt 8
```

This command will download the files listed in `mylinks.txt` using 8 threads for each download.

### Automatic Installation of Axel

The plugin includes a helper function that checks if `axel` is installed on your system. If not, it attempts to install it using the appropriate package manager for your Linux distribution:

- **Debian/Ubuntu**: `apt`
- **Red Hat/CentOS**: `yum`
- **Arch Linux**: `pacman`
- **Alpine Linux**: `apk`

If your distribution is not supported, you will need to install `axel` manually.


