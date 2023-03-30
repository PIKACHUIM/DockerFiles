#!/bin/bash
while [ true ];
do
  source Scripts/Titles.sh
  echo "   ==================================Menu=================================="
  echo "      [c] [CREATED] Create A New Docker Container from an Image"
  #echo "      [2] [DISPLAY] Display All Docker Containers in the System"
  #echo "      [3] [CONTROL] Start or Stop Your Docker Container Created"
  #echo "      [4] [DELETE ] Select and Delete Your Docker Container Now"
  echo "      [q] [ EXIT~ ] Do nothing, just exit this script! Bye~~~~~"
  echo "   ========================================================================"
  echo  
  unset OP_TYPE
  while [ ! $OP_TYPE ];
  do
    echo -n "   Choose Operation Type Number(c): "
    read OP_TYPE
    if [ ! $OP_TYPE ]; then
      echo "   Error: You must enter Type Number!!"
    else
      break
    fi
  done
  # Create ------------------------------------------------------------------------
  if [ $OP_TYPE == c ]; then
    source Scripts/Create.sh
  elif [ $OP_TYPE == 'q' ]; then
      exit 0
  fi
done