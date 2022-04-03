defaults write com.apple.Finder FXPreferredViewStyle Nlsv

chflags nohidden ~/Library

defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10
defaults write -g com.apple.trackpad.scaling -int 5
defaults write -g com.apple.keyboard.fnState -int 1
