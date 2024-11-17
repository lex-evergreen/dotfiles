# Lex's dotfiles

## Initial setup
### Container setup
Distrobox only mounts your host's `~` (home), but your container's `~` can be somewhere else so that dotfiles can be different and not cross-contaminate.

- Install Distrobox
- Clone this repo to `~/distrobox-homes/dev-fedora`
- Run the following commands inside that directory
```sh
distrobox assemble create --file dev-fedora.ini
distrobox enter dev-fedora
```
- If you're login shell isn't `fish`, change that now
```sh
chsh -s /usr/bin/fish
```
- Install packages. Here are some useful sets
```sh
# development
sudo dnf install neovim git-credential-oauth luarocks dotnet-sdk-8.0 rustup pnpm npm
```
The following can be found [here](https://v2.tauri.app/start/prerequisites)
```sh
# tauri
sudo dnf install webkit2gtk4.1-devel openssl-devel curl wget file libappindicator-gtk3-devel librsvg2-devel
sudo dnf group install "c-development"
```
I've tried adding these to the `additional_packages` section of `dev-fedora.ini`, but for some reason they create some folders as owned by the `root` of the container (not the root of the host), and this causes permissions issues. For example, installing `neovim` this way currently creates the `.local` folder as owned by `root` instead of the user. This is why packages are installed manually in these instructions.
- Perform some initial setup
```sh
git credential-oauth configure
git config --global user.email [email]
git config --global user.name [name]
```

### Entering the container automatically
If you're using a terminal emulator that can run a custom command at start, you can set it to the following to automatically enter the container when you open the terminal.
```
distrobox enter dev-fedora
```

