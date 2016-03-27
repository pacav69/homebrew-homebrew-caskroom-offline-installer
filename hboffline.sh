
#!/bin/sh
# ============================================
# This is an offline installer application of homebrew cask.
# ============================================
# Procedure:
# First use a Mac that is connected to the internet to download the files that will be used
# for offline usage. Then copy the downloaded files from the /Library/Caches/Homebrew directory
# to an external drive directory such as /homebrewfiles/Library/Caches/Homebrew
# or use the copycache.sh script
# ============================================
# What it does:
# This will change the environment variable of HOMEBREW_CACHE to the current dir 
# and the path of /Library/Caches/Homebrew
# Then loading the file list of 'local.apps' it will check and install apps 
# then it will load the file list of 'local.formulas' and check and install formulas.
# 
# ============================================

# clear

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

fancy_echo "Changing HOMEBREW_CACHE to current location"
export HOMEBREW_CACHE="${PWD}/Library/Caches/Homebrew"


brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      fancy_echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      fancy_echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    fancy_echo "Installing %s ..." "$1"
    brew install "$@"
    # todo: add in if failure to get file then try proxy
    # http_proxy=http://<proxyhost>:<proxyport> brew install $FORMULA
  fi
}

brew_is_installed() {
  brew list -1 | grep -Fqx "$1"
}

brew_is_upgradable() {
  ! brew outdated --quiet "$1" >/dev/null
}

brew_tap_is_installed() {
  brew tap | grep -Fqx "$1"
}

brew_tap() {
  if ! brew_tap_is_installed "$1"; then
    fancy_echo "Tapping $1..."
    brew tap "$1" 2> /dev/null
  fi
}

brew_cask_expand_alias() {
  brew cask info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_cask_is_installed() {
  local NAME
  NAME=$(brew_cask_expand_alias "$1")
  brew cask list -1 | grep -Fqx "$NAME"
}

app_is_installed() {
  local app_name
  app_name=$(echo "$1" | cut -d'-' -f1)
  find /Applications -iname "$app_name*" -maxdepth 1 | egrep '.*' > /dev/null
}

brew_cask_install() {
  if app_is_installed "$1" || brew_cask_is_installed "$1"; then
    fancy_echo "$1 is already installed. Skipping..."
  else
    fancy_echo "Installing $1..."
    brew cask install "$@"
  fi
}

brew_tap 'caskroom/cask'

brew_install_or_upgrade 'brew-cask'

brew_tap 'caskroom/versions'

# brew_cask_install 'atom'

# Install apps
fancy_echo 'Checking and installing Apps'
  if [ -f "$PWD/local.apps" ]; then
	  . "$PWD/local.apps"
  fi

# Install formulas
fancy_echo 'Checking and installing formulas'
	if [ -f "$PWD/local.formulas" ]; then
	  . "$PWD/local.formulas"
	fi

export HOMEBREW_CACHE='/Library/Caches/Homebrew'

fancy_echo 'Changing HOMEBREW_CACHE to default location'


# echo "$HOMEBREW_CACHE"

fancy_echo 'All done!'

