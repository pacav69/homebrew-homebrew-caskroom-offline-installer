#!/usr/bin/env bash
# @name bkupbrew.sh
# @description this script will backup brew and brew cask files
# @version v0.0.2
# @changelog v0.0.2 changed cp to rsync


# /usr/local/Library files

from_dir="/usr/local/Library"
to_dir="${PWD}/usr/local/"


if [ ! -d "$to_dir/Library/" ]; then
  mkdir -pv "$to_dir/Library/"
fi
echo "Copying Brew Library"
# cp -nvR ${from_dir} $to_dir
rsync -rvuh ${from_dir} $to_dir --progress --exclude=.DS_Store --stats --safe-links


# usr/local/bin
echo "Copying Brew file"
if [ ! -d "$to_dir/bin/" ]; then
  mkdir -pv "$to_dir/bin/"
fi

cp -v /usr/local/bin/brew $to_dir/bin/brew

