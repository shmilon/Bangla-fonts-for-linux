#!/bin/bash
#-------------------------------
#	Created By Sazid Hasan Milon
#
#	You could email me at shams007.bd@gmail.com or me@shmilon.com
#-------------------------------

echo "Welcome to http://shmilon.com !!!"
echo "------------------------------------"
echo "Now starting to download and install all bangla fonts..........."
echo "------------------------------------"


# Variables
downloadUrls=("https://goo.gl/ZPgs9g" "https://goo.gl/ZJ3VHp")
finalurl="" # it will select lowest latency mirror


# Get arrays of latency and plain urls.
point=()
pointPlus=()
finalu=()

for i in ${downloadUrls[@]};do 
  a=$(echo $i | sed 's|http://||g' | sed 's|https://||g' | cut -d '/' -f -1)
  aa=$(ping -c 5 "$a" | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  aaa=${aa%.*}
  point+=("$aaa")
  pointPlus+=("$aaa,$a")
  finalu+=("$aaa,$i")
done


# Calculate Minimum Latency
#---------------------------
max=${point[0]}
min=${point[0]}

echo $min
# Loop through all elements in the array
for i in "${finalu[@]}"
do
    a=$(echo $i | cut -d ',' -f 1)
    # Update max if applicable
    if [[ "$a" -gt "$max" ]]; then
        max="$i"
    fi

    # Update min if applicable
    if [[ "$a" -lt "$min" ]]; then
        min="$i"
    fi
done
finalurl=$(echo $min | cut -d ',' -f 2)


if [ $USER = "root" ]; then
  fontsDir="/root/.fonts/lsaBanglaFonts"
fi
if [ $USER != "root" ]; then
  fontsDir="/home/$USER/.fonts/lsaBanglaFonts"
fi



echo -e "\n"

if [ ! -d "$fontsDir" ]; then
  mkdir -p $fontsDir
else
  echo -e "Now upgrading bangla fonts provided by us....\n";
  rm -r $fontsDir;
fi

echo -e "\n"
echo -e "Downloading the fonts compressed file....\n"
echo -e "\n"
echo $finalurl
wget -v -P $fontsDir"/" $finalurl

cd $fontsDir"/"
tar -zxvf lsaBanglaFonts.tar.gz
rm lsaBanglaFonts.tar.gz

cd

echo -e "\n"
echo -e "Initiating font refresh......\n"
fc-cache -f -v
echo -e "\n"

echo "------------------------------------"
echo "Download and Installation Complete !!!"
echo -e "Script is Created by Sazid Hasan Milon\n"
echo -e "Website: http://shmilon.com\n"
echo -e "Follow Me at https://twitter.com/sazidhasanmilon\n"
echo -e "Follow Me at https://github.com/shmilon\n"
