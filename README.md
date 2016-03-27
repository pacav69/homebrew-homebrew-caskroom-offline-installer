# caskroom-offline-install

MAC app downloader and installer using Homebrew and Homebrew cask

Edit the hb.apps.txt, hb.formulas.txt and hb.pips.txt
for your required files

Then run ./macinst from the command line to download and install

## Offline installation
If you require an offline installation
## Introduction
This is an offline installer application of homebrew cask.

## Procedure:
First download and install homebrew visit homebrew.org
Then use a Mac that is connected to the internet to download the files that will be used
for offline usage. Then copy the downloaded files from the /Library/Caches/Homebrew directory
to an external drive directory such as /homebrewfiles/Library/Caches/Homebrew
or use the copycache.sh script.

## What it does:
The script hboffline.sh will change the environment variable of HOMEBREW_CACHE to the current dir and add the path of /Library/Caches/Homebrew
Then loading the file list of 'local.apps' it will check and install apps 
# then it will load the file list of 'local.formulas' and check and install formulas.
# 
# ============================================

## Usage
first create a 'hboffline' directory on the external drive
then copy the following files to this directory

bkupbrew.sh
copycache.sh
hboffline.sh
local.apps
local.formulas

open a terminal on the external drive in the hboffline directory and run the following:

use ./copycache.sh

this will copy from the /Library/Caches/Homebrew on the computer to the external drive

edit the local.apps and the local.formulas for your required install

then run ./hboffline.sh

this will allow an offline install of the previously downloaded files.

use ./bkupbrew.sh to copy files from the /usr/local/Library and Brew file to 
the external drive






