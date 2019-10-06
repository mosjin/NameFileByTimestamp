#!/bin/bash

# rename files name by there creating timestamp on Windows/Linux.
# mosjin

oggs=$(ls -l --full-time  | awk -F" " '{print $7,$9}' | sort  | awk '{print $2}' | egrep -v "^[^a-zA-Z]" | egrep -v "^ *$" | grep -v "bash")
num=1

echo "Renaming..."
for fil in ${oggs} 
do

	printf -v no "%03d" ${num}
	fileName=$(echo ${fil} | cut -d"_" -f1)
	dateYear=$(echo ${fil} | cut -d"_" -f2)
	dateTime=$(ls -l --full-time ${fil} | awk -F" " '{print $7}' | cut -d"." -f1 | sed 's/:[0-9]*$//' | sed 's/://')		
	suffix=$(echo ${fil} | cut -d"." -f2)
	
	finalName=$(echo ${fileName}_${dateYear}_${dateTime}_${no}.${suffix})
	num=$((num+1))
	
	#echo ${fil} ${finalName}	
	mv ${fil} ${finalName}

done


echo ""
ls -l --full-time | awk '{print $7, $9}' | sort | grep -v bash
echo Done!
