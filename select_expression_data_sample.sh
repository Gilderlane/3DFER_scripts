#!/bin/bash

########################################################################################
# Selects data sample for expression recognition and saves in specific directories
# ambiente_dir holds the path to your "AMBIENTE3D" directory
# usage: ./select_expression_data_sample.sh "/path/to/AMBIENTE3D/directory"
########################################################################################

ambiente_dir=$1
input_dir="${ambiente_dir}/DATA/bosphorus-outlier-density200-crop80-icp/completa/faces" # Change 'faces' to landmarks and run again
output_dir1="../../DATA/bosphorus-outlier-density200-crop80-icp/FER/faces/emotions" # Change 'faces' to landmarks and run again
output_dir2="../../DATA/bosphorus-outlier-density200-crop80-icp/FER/faces/neutrals" # Change 'faces' to landmarks and run again

mkdir -p $output_dir1
mkdir -p $output_dir2

green=`tput setaf 2`
reset=`tput sgr0`

count_files=$(ls $(dirname $(dirname $output_dir1))/bosphorus_expressive_subjects_*.txt 2>/dev/null | wc -l)
# If there is no list of balanced expressive subjects, make it
if [[ "$count_files" -eq "0" ]]; then
	./list_expressive_subjects_only.sh "$ambiente_dir"
	echo "${green}Done!"
fi

file_name=$(ls $(dirname $(dirname $output_dir1))/bosphorus_expressive_subjects_*.txt)

# For each selected subject, select its emotional and neutral samples
while read subject
do
	ln -s $(ls $input_dir/$subject/*_E_*.pcd) $output_dir1
	ln -s $(ls $input_dir/$subject/*_N_*.pcd) $output_dir2
done < $file_name

#Feedback message
echo
echo "${green} Data sample selection done!" 
echo


