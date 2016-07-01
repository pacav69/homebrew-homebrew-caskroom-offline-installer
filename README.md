# Brew and Brew Cask OffLine installer

# Purpose
The purpose of these apps is to provide an offline installer for brew and brew cask files.


# Usage
These files provide a method to install apps on Mac computers: 
* for a new install of the Operating System
* that don't have an internet connection
* that are newly purchased
* that are on a network
* to save having to download files repeatively 



## Appname: crelist.sh - create list
Description: creates a list of installed homebrew and homebrew-cask files and stores them in hblist.csv and hbclist.csv
Usage: On the technician's computer run this script then copy the created files and the files stored in the cache directory to an external drive.
from the command line run:
```
./crelist
```
this will create two files hblist.csv and hbclist.csv in the current directory.
Then edit the files to the desired requirements.


## Appname: olinst - OffLine install
Description: this script will install homebrew and homebrew-cask files from a list stored in a hblist.csv and hbclist.csv or 
a filename from the command line.
 
### Options:

    usage: ./olinst [options] <file_name>

    options:
      -c <file_name>                  Cask Filename list to use for install.
      -b <file_name>                  Brew Filename list to use for install.
      -uc <file_name>                 Update Cask Filename list to use.
      -h, --help                      Show this help.
      If no filename is given then app will use the default files hblist.csv and hbclist.csv

examples from the command line run:

```
./olinst
```
this will install the files that are listed in hblist.csv and hbclist.csv files

```
./olinst -c newinst.csv
```
this will install the brew cask files that are listed in newinst.csv
    

```
./olinst -b mybrew.csv
```
this will install the brew files that are listed in mybrew.csv
    
```
./olinst -uc ucask.csv
```
this will update the brew cask files installed that are listed in ucask.csv
    

### hbclist.csv options
In the hbclist.csv if the second value is null then the appname will install to ~/Applications directory, otherwise if the second value is "A" then the app will install to /Applications directory

## Appname: cppi - Copy Preferences and Plug In's
Description: copies preferences and plugins to the relevant directories.
Usage: Install the app {appname}, make changes to your requirements eg colors, fonts etc and install plugins
Copy files from $HOME/Library/Application Support/{appName} to appSupportDir or Copy files from /Library/Application Support/{appName} to appSupportDir and add "a" to
appsloc.csv file so that it reads like this:
```
{appName},a,
```

so that the app will use the alternative location for copying files.

Copy files from $HOME/Library/Preferences/{appName} to appPrefDir or Copy files from /Library/Preferences/{appName} to appPrefDir and add "a" to
appsloc.csv file so that it reads like this:
```
{appName},,a
```

so that the app will use the alternative location for copying files.
or a combination of both
```
{appName},a,a
```

Add {appName}, {appSupportDir}, {appPreferences} to appsloc.csv making sure that each field is separated with a comma including spaces in the directory names and matches the directory names in the appSupportDir and appPrefDir directories.
Where 
* {appName} is the brew cask name
* {appSupportDir} is the directory located in the '$HOME/Library/Application Support' directory or use "a" so that it will use the alternative '/Library/Application Support'
* {appPreferences} is the directory located in the '$HOME/Library/Preferences/' directory or use "a" so that it will use the alternative '/Library/Preferences/'

for example the contents of appsloc.csv
```
sublime-text3,Sublime Text 3,Sublime Text 3
```

from the command line run:
```
cppi.sh
```

this will then load the list from appsloc.csv and then copy the support files and preferences to the relevant directories based on {appname} if installed.

## Appname: copycache.sh
Description: this script copies files from the $HOME/Library/Caches/Homebrew to the external drive + /Library/Caches/Homebrew
usage run this script from the command line on an external drive under a sub directory such as hbcoffline

from the command line on an external drive run:

```
./copycache.sh
```

## Appname: bkupbrew.sh - backup brew and brew cask files
Description: this script will backup brew and brew cask files

from the command line on an external drive run:
```
./bkupbrew.sh
```
## Appname: creuclist.sh  create a file list of homebrew-cask updates
Description: creates a list of installed homebrew-cask files that have updates and stores them in uclist.csv
Usage: On the technician's computer run this script then copy the files from the cache directory

from the command line run:
```
./creuclist.sh
```
this will create uclist.csv file
including 'latest'
then adjust to your requirements.

from the command line run:
```
./olinst -uc uclist.csv
```
this will then update and uninstall 'latest' then install apps that are listed in the file.