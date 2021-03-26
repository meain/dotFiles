#!/bin/sh

# mac settings
defaults write com.apple.screencapture location ~/Documents/Screenshots/  # change scresnshot dir
defaults write com.apple.Terminal AppleShowScrollBars -string WhenScrolling  # no scrollbar in mac terminal
defaults write -g ApplePressAndHoldEnabled -bool false  # enable key repeat
sudo nvram SystemAudioVolume="%00"  # no boot bell
defaults write com.apple.universalaccess reduceTransparency -bool true  # disable transparency
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2  # medium sidebar icon size
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false  # save to disk instead of iCloud by default
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true  # quit printer app after print
# defaults write com.apple.LaunchServices LSQuarantine -bool false  # disable "Are you sure you want to open this app" thing
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1  # use tap instead of click on trackpad  ## TODO: maybe -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1  # use tap instead of click on trackpad
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1  # use tap instead of click on trackpad
defaults write NSGlobalDomain KeyRepeat -int 1  # key repeat speed
defaults write NSGlobalDomain InitialKeyRepeat -int 15  # inital key repeat delay
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true  # no .DS_Store on network devices
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true  # no .DS_Store on USB storage
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"  # search current dir in finder by deafult
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"  # set listview as prefered view in finder
defaults write com.apple.dock tilesize -int 20  # smaller dock icons
defaults write com.apple.dock mouse-over-hilite-stack -bool false  # no highlight effect on docker grid view
defaults write com.apple.dock minimize-to-application -bool false  # minimise to indivual app spots
defaults write com.apple.dashboard mcx-disabled -bool true  # disable dashboard
defaults write com.apple.dock dashboard-in-overlay -bool true  # do not show dashboard as a space
defaults write com.apple.dock mru-spaces -bool false  # do not rearrange spaces based on recently used
defaults write com.apple.dock autohide -bool true  # automatically show and hide dock
defaults write com.apple.dock showhidden -bool true  # made hidden app icons translucent in dock
defaults write com.apple.dock show-recents -bool false  # do not show recent apps in dock
defaults write com.apple.ActivityMonitor IconType -int 5  # show cpu usage in activity monitor icon

# Setup macOS hot corners
# 0:no-op 2:Mission Control 3:Show application windows 4:Desktop
# 5:Start screen saver 6:Disable screen saver 7:Dashboard
# 10:Sleep display 11:Launchpad 12:Notification Center 13:Lock Screen
defaults write com.apple.dock wvous-tl-corner -int 2  # top-left
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 2  # top-right
defaults write com.apple.dock wvous-tr-modifier -int 0

execcommandfrompartial() {
    BASE=$1
    FILENAME=$2

    # comments and blank lines will be removed
    CONTENT="$(sed 's/\s*#.*//g; /^$/d' "$FILENAME")"

    while read -r item; do
        COMMAND="$BASE $item"
        $COMMAND
    done <<< "$CONTENT"
}

# homebrew packages
if test ! "$( which brew )"; then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi
execcommandfrompartial 'brew install' './brew.packages'

# homebrew cask
execcommandfrompartial 'brew install --cask' './brew-cask.packages'

# install non package stuff
bash ./non-package.sh

# npm packages
execcommandfrompartial 'npm install -g' './node.packages'

# python3 packages
execcommandfrompartial 'pip3 install' './python3.packages'

# go packages
execcommandfrompartial 'go get -vu' './go.packages'

# tex packages
execcommandfrompartial 'sudo tlmgr install' './go.packages'

# rust packages
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rust-src
execcommandfrompartial 'cargo install' './cargo.packages'

# more setup
defaults write org.hammerspoon.Hammerspoon MJConfigFile "$HOME/.config/hammerspoon/init.lua"

# enable at (https://superuser.com/questions/43678/mac-os-x-at-command-not-working)
sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.atrun.plist
