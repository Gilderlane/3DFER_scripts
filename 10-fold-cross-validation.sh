#!/bin/bash

############################################################################
# Performs ONE independent round of 10-fold cross-validation
# ambiente_dir holds the path to your "AMBIENTE3D" directory
# usage: ./10-fold-cross-validation.sh "/path/to/AMBIENTE3D/directory"
############################################################################

ambiente_dir=$1
input_dir="${ambiente_dir}/DATA/bosphorus-outlier-density200-crop80-icp/FER/faces"
output_dir="${ambiente_dir}/DATA/bosphorus-outlier-density200-crop80-icp/FER/results/10-fold"

count_files=$(ls $(dirname $input_dir)/bosphorus_expressive_subjects_*.txt 2>/dev/null | wc -l)

# If there is no list of balanced expressive subjects, make it
if [[ "$count_files" -eq "0" ]]; then
	./list_expressive_subjects_only.sh
	echo "${green}Done!"
fi

_65_subjs=$(ls $(dirname $input_dir)/bosphorus_expressive_subjects_*.txt)
_60_subjs=$output_dir/_60temp.txt #/dev/temp/temp.txt

# Randomly selects 60 subjects out of the set of balanced expressive ones
cat $_65_subjs | shuf | head -60 > $_60_subjs

# Randomly splits the 60 subjects into 10 groups 
for (( i = 60; i >= 6; i-=6 )); do
	j=$(($i / 6))
	cat $_60_subjs | tail -"$i" | head -6 | sort > $output_dir/group$j.txt
	
done

# Classification experiment
for (( i = 1; i <= 10; i++ )); do
	test_subjects= cat $output_dir/group$i.txt 
	# echo $(cat $output_dir/group$i.txt | wc -l)
	train_subjects= cat $(ls $output_dir/group*.txt | grep -v $output_dir/group$i.txt)
	# echo $(cat $(ls $output_dir/group*.txt | grep -v $output_dir/group$i.txt) | wc -l)
	# script de treinamento e teste
done
