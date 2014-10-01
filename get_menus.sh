#!/bin/bash

#have bash terminate if any errors
#set -e




function search_menu()
{
  cafe_name=$1
  wget -O $cafe_directory/$cafe_name.html "http://menu-mtv-$cafe_name.blogspot.com/" && number_bacons=`grep -c "$ingredient" $cafe_directory/$cafe_name.html`
  echo "$cafe_name has $number_bacons bacons" >> $bacons/bacons.txt
}

ingredient=bacon

cafe_directory=./cafes
bacons=./bacons

echo $cafe_directory

if [ ! -d $cafe_directory ]; then
  mkdir -p $cafe_directory
else
  rm -f $cafe_directory/*.html
  rm -f $cafe_directory/*.txt
fi

if [ ! -d $bacons ]; then
  mkdir -p $bacons
else
  rm -f $bacons/*.txt
fi

cafe_array=( "masa" "atom" "baadal" "backyard" "beta" "betac" "bigtable" "blaze" "charlies" "crave" "evolution" "go" "jia" "kitchensync" "longlife" "lunchbox" "masa" "maverick" "moma" "nourish" "root" "slice" "steam" "stockmarket" "victoria" "yoshka" "quadhalftime" "quadhangout" "quadportal" "trux")

for cafe_name in "${cafe_array[@]}"
do
  search_menu "$cafe_name" &
done
