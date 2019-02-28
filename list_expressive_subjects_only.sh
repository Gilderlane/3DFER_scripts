#!/bin/bash

#########################################################################################################
# Lists all subjects that have samples of all six emotional expressions and saves the list in a text file
#########################################################################################################

mestrado_dir="/home/latin/Documentos/MESTRADO"
input_dir="${mestrado_dir}/DATA/bosphorus-outlier-density200-crop80-icp/completa/faces"
output_dir="../../DATA/bosphorus-outlier-density200-crop80-icp/FER"
date=$(date +'%Y%m%d')
file_name="bosphorus_expressive_subjects_${date}.txt"
green=`tput setaf 2`
reset=`tput sgr0`

# For each subject directory
for subject in $(ls $input_dir)
do
	# If the count of expressive samples is superior to six, list subject identifier
	if [ "$(ls $input_dir/$subject/*_E_* 2>/dev/null | wc -l)" -eq "6" ] ; then
	echo $subject >> $output_dir/$file_name
	fi
done
#Feedback message
echo
echo "File ${green}'$file_name' ${reset}successfully saved in the directory: ${green} $output_dir"/ ${reset}
echo