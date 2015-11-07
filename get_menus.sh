#!/bin/bash +x

#have bash terminate if any errors
#set -e

#mod the ingredient here
ingredient=bacon

function search_menu()
{
  cafe_short_name=$1
  cafe_url="http://menu-mtv-$cafe_short_name.blogspot.com/" 
  cafe_name=$2
  wget -O $cafe_directory/$cafe_short_name.html "http://menu-mtv-$cafe_short_name.blogspot.com/" && number_bacons=`grep -i -c "$ingredient" $cafe_directory/$cafe_short_name.html`
  echo "{\"cafe_short_name\" : \"$cafe_short_name\",\"cafe_url\" : \"$cafe_url\", \"cafe_name\" : \"$cafe_name\",\"number_bacons\" : \"$number_bacons\"}," >> $bacons/bacons.json

  # get the entire text into a single line
  big_file=`grep -i "JSON Menu" $cafe_directory/$cafe_short_name.html | sed 's/^.*\(JSON Menu.*\)$/\1/g' | sed "s/[\"':;,[->\/-]/ /g" | sed "s/ \+/ /g"`
  echo "$cafe_short_name : $big_file">> menus.txt
}


#use this so we can run it from crontab
root_directory=/root/node/nodetest1/public/google_food

cafe_directory=$root_directory/cafes
bacons=$root_directory/bacons

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
  rm -f $bacons/*.json
fi

cafe_array=("baadal" "backyard" "beta" "betac" "bigtable" "blaze" "charlies" "crave" "evolution" "go" "jia" "kitchensync" "longlife" "lunchbox" "masa" "maverick" "moma" "nourish" "root" "slice" "steam" "stockmarket" "victoria" "yoshka" "quadhalftime" "quadhangout" "quadportal" "trux")

cafe_name=( "Baadal Café" "Backyard Café" "Beta Café" "beta C Café" "Big Table Café" "Blaze Café" "Charlie's Café" "Crave Café" "Evolution Café" "Go! Café" "Café Jia" "KitchenSync Café" "Long Life Café" "The Lunch Box Café" "Masa Café" "Maverick Café" "Café Moma" "Nourish Café" "Root Café" "Slice Café" "Steam Café" "Stock Market Café" "Victoria Deli" "Yoshka's Café" "Halftime" "Hangout" "Portal" "Trux Café" )


cafe_length=${#cafe_array[@]}

echo "myJsonMethod([" >> $bacons/bacons.json
for (( i=0; i<$cafe_length; i++));
do
  search_menu "${cafe_array[$i]}" "${cafe_name[$i]}"
done

echo "{\"cafe_short_name\" : \"blank\", \"cafe_url\" : \"blank\", \"cafe_name\" : \"blank\",\"number_bacons\" : \"0\"}" >> $bacons/bacons.json
echo "]);" >> $bacons/bacons.json
