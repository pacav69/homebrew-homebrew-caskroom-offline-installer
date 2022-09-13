#!/usr/bin/env bash
# @Appname: creuclist  create a file list of homebrew-cask updates
# @version: 0.0.3
# @Description: creates a list of installed homebrew-cask files that have updates and stores them in
# uclist.csv
# @Usage: On the technician's computer run this script
# edit uclist.csv to your requirements
# then run olinst

echo "Performing brew update to get the latest casks"
brew update

inputfile="uclist.csv"

if [ -f "$inputfile" ]; then
        echo "$inputfile file found deleting"
        rm -f $inputfile
        # return
      else
        echo "$inputfile file not found"
        # return -1
fi

echo "Creating homebrew cask list of updateable apps"

casks=( $(brew cask list) )
for cask in ${casks[@]}; do
    current="$(brew cask info $cask | sed -n '1p' | sed -n 's/^.*: \(.*\)$/\1/p')"
    auto_updates="$(brew cask cat $cask | sed -n s/'auto_updates '//p | sed -n 's/^.* \(.*\)$/\1/p')"
    installed=( $(ls /usr/local/Caskroom/$cask))
    # if value of current equals latest and auto_updates is not true then add to the uclist.csv
    # if value of current equals latest and auto_updates is true then add to the uclatestlist.csv
    # if value of current is not equal to value of installed then add to the uclist.csv
    # else skip
    if [ "$current" = "latest" ]; then
        echo "$(tput sgr0)$(tput rev) ✔ $(tput sgr0) Adding $cask $current to upgrade list file"
        if [ "$auto_updates" = "true" ]; then
            echo $cask,$current,$auto_updates >>uclatestlist.csv
        else
            # echo "$cask,$current"
            echo $cask,$current >>uclist.csv
        fi
    else
        if (! [[ " ${installed[@]} " == *" $current "* ]]); then
        echo "$(tput sgr0)$(tput rev) ✔ $(tput sgr0) Adding $cask v$current to upgrade list file "
        echo $cask >>uclist.csv
    fi
# display skipping cask when no updates to do.
    #else
#        if [ $current = "latest" ]; then
#            echo "$cask $current is up-to-date, skipping."
#        else
#            echo "$cask v$current is up-to-date, skipping."
#        fi
    fi
done