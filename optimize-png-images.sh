#!/bin/bash
if [ -z $1 ] ; then
  echo "Error: You need to enter a path containing png images!" && exit 1;
fi
pngnq $(find $1 -type f -name '*.png') -e -temp.png 2>/dev/null # Performs quantization
rm $(find $1 -type f -name '*.png' | grep -v "\-temp.png") # Removes old images files
find $1 -type f -name '*.png' | grep "\-temp.png" | awk -F '-temp.png' '{print "mv "$1"-temp.png "$1".png"}' > temp-script.sh # Creates a temporary script that will remove the "-temp" suffix
sh temp-script.sh # Run the temporary script
rm temp-script.sh # Removes the temporarary script
optipng $(find $1 -type f -name '*.png') 2>/dev/null # Optimizes the result
echo "Finished!"
