# caskroom-offline-install

MAC app downloader and installer using Homebrew and Homebrew cask.

Edit the hb.apps.txt, hb.formulas.txt and hb.pips.txt
for your required files.

Then run from the command line to download and install.

	./macinst

## Offline installer
## Introduction

This is an offline installer application of homebrew cask (HBC). 

## Procedure:

First download and install homebrew visit http://brew.sh/
Then using a Mac that is connected to the internet to download the files, suggest using macinst, that will be used for offline usage. Then copy the downloaded files from the /Library/Caches/Homebrew directory to an external drive directory such as /hbcoffline/Library/Caches/Homebrew
or use the copycache.sh script.

## What it does:
The script hbcoffline.sh will change the environment variable of HOMEBREW_CACHE to the current dir, whereever it is run and add the path of /Library/Caches/Homebrew

Then loading the file list of 'local.apps' it will check and install apps then it will load the file list of 'local.formulas' and check and install formulas.

## Usage
First create a 'hbcoffline' directory on the external drive then copy the following files to this directory.

* bkupbrew.sh
* copycache.sh
* hbcoffline.sh
* local.apps
* local.formulas

Open a terminal on the external drive in the 'hbcoffline' directory and run the following:

	./copycache.sh

This will copy files from the /Library/Caches/Homebrew on the computer to the external drive
of 'hbcoffline'

Edit the local.apps and the local.formulas for your required install.

Then run

	./hbcoffline.sh

This will allow an offline install of the previously downloaded files.

use


	./bkupbrew.sh 

to copy files from the /usr/local/Library and Brew file to 
the external drive.

## Recommend installing
go2shell 
visit http://zipzapmac.com/Go2Shell
or use 

	brew cask install go2shell





