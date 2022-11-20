# Kristijan's dotfiles

Bootstrap your Ubuntu in a single command!

# Install

https://github.com/tcardonne/dotfiles

sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

This dotfiles repository is currently aimed for [**Ubuntu on WSL**](https://ubuntu.com/wsl)

Managed with [`chezmoi`](https://chezmoi.io), a great dotfiles manager.

## Getting started

You can use the [convenience script](./scripts/install_dotfiles.sh) to install the dotfiles on any machine with a single command. Simply run the following command in your terminal:

```bash
sh -c "$(wget -qO- https://raw.githubusercontent.com/baky0905/dotfiles/HEAD/scripts/install_dotfiles.sh)"
```

> 💡 We use `wget` here because it comes preinstalled with most Ubuntu versions. But you can also use `curl`:
>
> ```bash
>  sh -c "$(curl -fsSL https://raw.githubusercontent.com/baky0905/dotfiles/HEAD/scripts/install_dotfiles.sh)"
> ```


### Convenience script

The [getting started](#getting-started) step used the [convenience script](./scripts/install_dotfiles.sh) to install this dotfiles. There are some extra options that you can use to tweak the installation if you need.

It supports some environment variables:

- `DOTFILES_REPO_HOST`: Defaults to `https://github.com`.
- `DOTFILES_USER`: Defaults to `baky0905`.
- `DOTFILES_BRANCH`: Defaults to `main`.

For example, you can use it to clone and install the dotfiles repository at the `beta` branch with:

```console
DOTFILES_BRANCH=beta sh -c "$(wget -qO- https://raw.githubusercontent.com/baky0905/dotfiles/HEAD/scripts/install_dotfiles.sh)"
```

### Installing without the convenience script

If you prefer not to use the convenience script to install the dotfiles, you can also do it manually:

```bash
git clone https://github.com/baky0905/dotfiles "$HOME/.dotfiles"

"$HOME/.dotfiles/install.sh"
```

---

### Forking guide

If you are forking this repository, don't forget to change the following places:

- [`README.md`](./README.md)
  - Replace all occurrences of `https://raw.githubusercontent.com/baky0905/dotfiles/HEAD/scripts/install_dotfiles.sh` with `https://raw.githubusercontent.com/<your-username>/dotfiles/HEAD/scripts/install_dotfiles.sh`
- [`scripts/install_dotfiles.sh`](./scripts/install_dotfiles.sh)
  - Replace all occurrences of `baky0905` with `<your-username>`
- [`home/.chezmoi.yaml.tmpl`](./home/.chezmoi.yaml.tmpl)
  - Change the name and email to yours.

Where `<your-username>` is your GitHub username.

---

### Extra scripts

There are some scripts here to help you automate tricky activities when setting up your machine.

If you already have this dotfiles [installed](#getting-started), you can use these scripts right away. Or, if you want to run it without installing the dotfiles, you can do something like:

```bash
bash -c "$(curl -fsSL "https://raw.githubusercontent.com/baky0905/dotfiles/main/scripts/<script-name>")" -- <arguments>
```

Just replace `<script-name>` and `<arguments>` with the desired values. Example:

