#!/bin/bash

# Install WezTerm via Homebrew Cask
echo "Installing WezTerm..."
brew install --cask wezterm
echo "Success"

# Install and set up WezTerm configuration
echo "Configuring WezTerm..."
cd "$HOME" && \
cd ".config/" && \
https://github.com/squirtward00/wezterm.git

# Install oh-my-zsh
echo "Installing oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "oh-my-zsh is already installed. Skipping..."
fi


# Install zsh plugins
echo "Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-syntax-highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting already installed. Skipping..."
fi

# zsh-autosuggestions
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions already installed. Skipping..."
fi

# Install Powerlevel10k theme
echo "Installing Powerlevel10k theme..."
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "$ZSH_CUSTOM/themes/powerlevel10k"
else
    echo "Powerlevel10k already installed. Skipping..."
fi

# Update .zshrc with plugins
echo "Configuring .zshrc..."
ZSH_RC="$HOME/.zshrc"

# Create .zshrc if it doesn't exist
touch "$ZSH_RC"

# Set Powerlevel10k theme
if ! grep -q "ZSH_THEME=" "$ZSH_RC"; then
    echo 'ZSH_THEME="powerlevel10k/powerlevel10k"' >> "$ZSH_RC"
else
    # Update existing theme declaration
    sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' "$ZSH_RC"
fi

# Ensure plugins are enabled
if ! grep -q "plugins=(" "$ZSH_RC"; then
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSH_RC"
else
    # Add missing plugins
    for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
        if ! grep -q "$plugin" "$ZSH_RC"; then
            sed -i '' "s/^plugins=(\(.*\))/plugins=(\1 $plugin)/" "$ZSH_RC"
        fi
    done
fi

# Add recommended Powerlevel10k configuration
if ! grep -q "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD" "$ZSH_RC"; then
    echo -e "\n# Avoid Powerlevel10k configuration wizard" >> "$ZSH_RC"
    echo "POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true" >> "$ZSH_RC"
fi

# Set zsh as default shell if its not
if ! grep -q "$(which zsh)" /etc/shells; then
    echo "Adding zsh to available shells..."
    sudo sh -c "echo $(which zsh) >> /etc/shells"
fi

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
else
    echo "zsh is already the default shell."
fi

cat <<EOF

Setup complete! Here's what was installed:

1. WezTerm terminal emulator
2. oh-my-zsh framework
3. Powerlevel10k theme
4. Additional zsh plugins:
   - zsh-syntax-highlighting
   - zsh-autosuggestions

After restarting your terminal:
1. Powerlevel10k configuration wizard will run automatically
2. Follow the prompts to customize your prompt
3. If the wizard doesn't run, type: p10k configure

Configuration files:
- WezTerm: ~/.config/wezterm/wezterm.lua
- ZSH: ~/.zshrc
- Powerlevel10k: ~/.p10k.zsh (will be created after configuration)
EOF
