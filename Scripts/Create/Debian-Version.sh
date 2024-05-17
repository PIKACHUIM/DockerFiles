#!/bin/bash
source Scripts/Titles.sh
echo "   ============================Available Version==========================="
echo "   [1] Debian 12 (Bookworm)                            [ √ Now Recommend]  "
echo "   [2] Debian 11 (Bullseye)                            [ × Not Recommend]  "
echo "   [3] Debian 10 (Buster)                              [ × Not Recommend]  "
echo "   ========================================================================"
echo
echo -n "   Choice System Version Number(1): "
read VERSION
if [ ! $VERSION ]; then
  echo Note: VERSION='Latest'
  VERSION='latest'
elif [ $VERSION == 1 ]; then
  echo Note: VERSION='Bookworm'
  VERSION='bookworm'
elif [ $VERSION == 2 ]; then
  echo Note: VERSION='Bullseye'
  VERSION='bullseye'
elif [ $VERSION == 3 ]; then
  echo Note: VERSION='Buster'
  VERSION='buster'
fi


