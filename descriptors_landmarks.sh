#!/bin/bash

############################################################################
# Extracts the coordinates of the 10 first landmarks as descriptors and saves
# them in the file descriptors_landmarks.csv
# ambiente_dir holds the path to your "AMBIENTE3D" directory
# usage: ./descriptors_landmarks.sh "/path/to/AMBIENTE3D/directory"
############################################################################

ambiente_dir=$1
input_dir="${ambiente_dir}/DATA/bosphorus-outlier-density200-crop80-icp/FER/landmarks/emotions"
output_dir="${ambiente_dir}/DATA/bosphorus-outlier-density200-crop80-icp/FER/descriptors"
date=$(date +'%Y%m%d')

mkdir -p $output_dir

echo "OUTER_LEFT_EYEBROW_X OUTER_LEFT_EYEBROW_Y OUTER_LEFT_EYEBROW_Z MIDDLE_LEFT_EYEBROW_X MIDDLE_LEFT_EYEBROW_Y MIDDLE_LEFT_EYEBROW_Z INNER_LEFT_EYEBROW_X INNER_LEFT_EYEBROW_Y INNER_LEFT_EYEBROW_Z INNER_RIGHT_EYEBROW_X INNER_RIGHT_EYEBROW_Y INNER_RIGHT_EYEBROW_Z MIDDLE_RIGHT_EYEBROW_X MIDDLE_RIGHT_EYEBROW_Y MIDDLE_RIGHT_EYEBROW_Z OUTER_RIGHT_EYEBROW_X OUTER_RIGHT_EYEBROW_Y OUTER_RIGHT_EYEBROW_Z OUTER_LEFT_EYE_CORNER_X OUTER_LEFT_EYE_CORNER_Y OUTER_LEFT_EYE_CORNER_Z INNER_LEFT_EYE_CORNER_X INNER_LEFT_EYE_CORNER_Y INNER_LEFT_EYE_CORNER_Z INNER_RIGHT_EYE_CORNER_X INNER_RIGHT_EYE_CORNER_Y INNER_RIGHT_EYE_CORNER_Z OUTER_RIGHT_EYE_CORNER_X OUTER_RIGHT_EYE_CORNER_Y OUTER_RIGHT_EYE_CORNER_Z SUBJECT EXPRESSION"> $output_dir/descriptors_landmarks_${date}.csv

for sample_file in $(ls $input_dir)
do
	descriptors=$(sed -n '12,21p' < $input_dir/$sample_file) 
	class_subject=$(echo $sample_file | cut -d'_' -f 1)
	class_expression=$(echo $sample_file | cut -d'_' -f 3)
	echo $descriptors $class_subject $class_expression >> $output_dir/descriptors_landmarks_${date}.csv
	
done
