## Install WezTerm:
****
**macos**
```bash
brew install --cask wezterm
```

**gentoo**
```bash
sudo emerge -av x11-terms/wezterm
```
_prolly it'll be masked so u gotta do:_
```bash
sudo echo "x11-terms/wezterm ~amd64" >> /etc/portage/package.accept_keywords/wezterm
```

**arch-based**
```bash
sudo pacman -S wezterm && (tput setaf 6; echo "SPECIFICALLY for you little cutie-patutie femboy ₍˄·͈༝·͈˄₎◞"; tput sgr0)
```

*****
## Install config
```bash
cd && cd .config && mkdir wezterm && git clone https://github.com/squirtward00/wezterm/wezterm.lua
```
