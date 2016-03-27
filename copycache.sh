# this script copies files from the /Library/Caches/Homebrew
# to the external drive + /Library/Caches/Homebrew

from_dir="/Library/Caches/Homebrew"
to_dir="${PWD}/Library/Caches/"

# cp -nvR /Library/Caches/Homebrew/atom-1.6.0.zip ./Library/Caches/Homebrew
if [ ! -d "$to_dir" ]; then
  mkdir "$to_dir"
fi
# cp -nvR ${from_dir}/atom-1.6.0.zip $to_dir
cp -nvR ${from_dir} $to_dir