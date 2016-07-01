#!/bin/bash
# @Appname: cppi Copy Preferences and Plug In's
# @version: 0.1.0
# @Description: copies plugins and preferences to the relevant directories
# @Usage: Install the app {appname}, make changes to your requirements eg colors, fonts etc
# install plugins
# Copy files from $HOME/Library/Application Support/{appName} to appSupportDir
# or Copy files from /Library/Application Support/{appName} to appSupportDir and add "a" to
# appsloc.csv file so that it reads like this:
# {appName},a,
# so that it will use the alternative location
# =============================================
# Copy files from $HOME/Library/Preferences/{appName} to appPrefDir
# or Copy files from /Library/Preferences/{appName} to appPrefDir and add "a" to
# appsloc.csv file so that it reads like this:
# {appName},,a
# so that it will use the alternative location
# or a combination of both
# {appName},a,a
#
# Add {appName}, {appSupportDir}, {appPreferences} to appsloc.csv making sure that each field
# is separated with a comma including spaces in the directory names and matches the directory
# names in the appSupportDir and appPrefDir directories.
# Where {appName} is the brew cask name
# {appSupportDir} is the directory located in the '$HOME/Library/Application Support' directory
# or use "a" so that it will use the alternative '/Library/Application Support'
# {appPreferences} is the directory located in the '$HOME/Library/Preferences/' directory
# or use "a" so that it will use the alternative '/Library/Preferences/'

# for example
# sublime-text3,Sublime Text 3,Sublime Text 3
#
# run cppi.sh - this will then load the list from appsloc.csv and then copy the support files
# and preferences to the relevant directories based on {appname} if installed.

fancy_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\n$fmt\n" "$@"
}

# ===========================
# appSupportDir
# ===========================
from_appSupportDir="appSupportDir"

# default location
to_appSupportDir="$HOME/Library/Application Support"
# alternative location
to_appSupportDirAlt="/Library/Application Support"

# ===========================
# app Preference
# ===========================
from_appPrefDir="appPrefDir"

# default location
to_appPref="$HOME/Library/Preferences/"
# alternative location
to_appPrefAlt="/Library/Preferences/"


# ===========================
# start copying preferences and plug-ins
# ===========================
function install_prefplugins {
# inputfile="appsloc.csv"
SaveIFS=$IFS
IFS=","
while read appName appSupportDir appPreferences; do
#echo "the first value is", ${appName}
#echo "the second value is", ${appSupportDir}
#echo "the third value is", ${appPreferences}
# fancy_echo "Checking if Application  \"${appName}\" is installed..."

# ===========================
# check if the app is installed
# ===========================
if brew cask list -1 | grep -Fqx ${appName}; then
    fancy_echo "${appName} is installed, adding files..."
    # ===========================
    # copy Application support files
    # if the appSupportDir value is null then test to see if there is a
    # directory of the appName
    # ===========================
    if [ -z "${appSupportDir}" ]; then
      fancy_echo " no ${appName} directory found in list trying $appName directory"
      if [ -d "$from_appSupportDir/$appName" ]; then
        fancy_echo "found $appName directory"
        fancy_echo "Adding files to the Application support \"${appSupportDir}\" directory"
        rsync -rvuh  "$from_appSupportDir/${appName}" "$to_appSupportDir" --progress --exclude=.DS_Store  --safe-links
      else
        fancy_echo "didn't find $appName directory"
      fi
    else
        fancy_echo "adding Application support files."
        if [ ${appSupportDir} == "a" ]; then
            fancy_echo "using alternative app support directory"
            sudo cp -nfvR "$from_appSupportDir/${appName}/" "$to_appSupportDirAlt/${appName}"
        else
            if [ -d "$from_appSupportDir/${appSupportDir}/" ]; then
                fancy_echo "using default support directory with user supplied directory"
                cp -nfvR "$from_appSupportDir/${appSupportDir}/" "$to_appSupportDir/${appSupportDir}"
            else
                fancy_echo "No support directory found"
            fi
        fi
    fi
    # ===========================
    # copying Preference files to appPref directories
    # if the appPreferences content is null then test to see if there is a
    # directory of the appName under appPrefDir
    # ===========================
    if [ -z "${appPreferences}" ]; then
    fancy_echo " no ${appName} preferences directory found in list trying $appName preferences directory"
      if [ -d "$from_appPrefDir/$appName" ]; then
        fancy_echo "found $appName preferences directory"
        rsync -rvuh  "$from_appPrefDir/${appName}" "$to_appPref" --progress --exclude=.DS_Store  --safe-links
      else
        fancy_echo "didn't find $appName preferences directory"
      fi
    else
        # ===========================
        # copying Preference files to alternative directories
        # ===========================
        fancy_echo "copying Preference files."
        if [ ${appPreferences} == "a" ]; then
        fancy_echo "using alternative app Preference directory"
           sudo cp -nfvR "$from_appPrefDir/${appName}/" "$to_appPrefAlt/${appName}"
        else
            if [ -d "$from_appPrefDir/${appPreferences}/" ]; then
                fancy_echo "using default Preference directory with user defined directory"
                cp -nfvR "$from_appPrefDir/${appPreferences}/" "$to_appPref/${appPreferences}"
            else
                fancy_echo "didn't find $appName preferences directory"
            fi
        fi
    fi

else
    fancy_echo "${appName} is NOT installed skipping"
fi

done < "$inputfile"
IFS=$SaveIFS
}

# ===========================
# if no appSupportDir or appPrefDir then create them
# ===========================
if [ ! -d "$from_appSupportDir" ]; then
  mkdir "$from_appSupportDir"
fi

if [ ! -d "$from_appPrefDir" ]; then
  mkdir "$from_appPrefDir"
fi
# ===========================
# check if appsloc.csv file exists
# ===========================
if [ -f "appsloc.csv" ]; then
    fancy_echo "appsloc.csv file found"
    inputfile="appsloc.csv"
    install_prefplugins
  else
    fancy_echo "appsloc.csv file not found"
    echo "atom">> appsloc.csv
    echo "sublime-text3,Sublime Text 3,Sublime Text 3">> appsloc.csv
    exit 1
fi

# ===========================
# Completed
# ===========================
fancy_echo "All tasks completed"
