#!/bin/bash
source Scripts/Titles.sh
echo "   ============================Available Version==========================="
echo "      [1] 22.04 Jammy Jellyfish  [ √ Now Recommend / Support Until 2032 ]  "
echo "      [2] 20.04 Focal Fossa      [ × Not Recommend / Support Until 2030 ]  "
echo "      [3] 18.04 Bionic Beaver    [ × Not Recommend / Support Until 2028 ]  "
echo "   ========================================================================"
echo
echo -n "   Choice System Version Number(1): "
read VERSION
if [ ! $VERSION ]; then
  echo Note: VERSION='22.04'
  VERSION='22.04'
elif [ $VERSION == 1 ]; then
  echo Note: VERSION='22.04'
  VERSION='22.04'
elif [ $VERSION == 2 ]; then
  echo Note: VERSION='20.04'
  VERSION='20.04'
elif [ $VERSION == 3 ]; then
  echo Note: VERSION='18.04'
  VERSION='18.04'
fi


