#!/bin/bash
#                                 _       _
#     /\                         (_)     | |
#    /  \   _ __ ___   ___  _ __  _  ___ | |_
#   / /\ \ | '_ ` _ \ / _ \| '_ \| |/ _ \| __|
#  / ____ \| | | | | | (_) | | | | | (_) | |_
# /_/    \_\_| |_| |_|\___/|_| |_| |\___/ \__|
#                               _/ |
#                              |__/
# 18/02/2026

# Set arguments
FWD=GTGYCAGCMGCCGCGGTAA
REV=CCGYCAATTYMTTTRAGTTT
TEMP="temp"
OUTPUT="oriented"

forward=$1

# Create result and temporary directory
## temp directory
if [ ! -f ${TEMP} ]; then
    mkdir ${TEMP}
fi
## output directory
if [ ! -f ${OUTPUT} ]; then
    mkdir ${OUTPUT}
fi

# Identify optimal overlap length to minimize false positive primer identification
LENGTH_FWD=$(echo ${FWD} | awk '{print length}')
LENGTH_REV=$(echo ${REV} | awk '{print length}')
if [[ "${LENGTH_FWD}" -le "${LENGTH_REV}" ]]
then
    OVERLAP=$(( ${LENGTH_FWD} - 1 ))
else
    OVERLAP=$(( ${LENGTH_REV} - 1 ))
fi

# Input
label=$(echo $forward | cut -d'_' -f1 | cut -d'/' -f2)
reverse=$(echo $forward | sed 's/_R1/_R2/g')

# Identify reads in valid direction
cutadapt -j 1 -e 0.1 --discard-untrimmed --action none -g ${FWD} -G ${REV} --overlap ${OVERLAP} -o ${TEMP}/${label}_clean_R1_in_R1.fastq.gz -p ${TEMP}/${label}_clean_R2_in_R2.fastq.gz ${forward} ${reverse}

# Identify reads in reverse direction
cutadapt -j 1 -e 0.1 --discard-untrimmed --action none -g ${REV} -G ${FWD} --overlap ${OVERLAP} -o ${TEMP}/${label}_clean_R2_in_R1.fastq.gz -p ${TEMP}/${label}_clean_R1_in_R2.fastq.gz ${forward} ${reverse}

# Save oriented reads
cat ${TEMP}/${label}_clean_R1_in_R1.fastq.gz ${TEMP}/${label}_clean_R1_in_R2.fastq.gz > ${OUTPUT}/${label}_clean_processed_R1.fastq.gz
cat ${TEMP}/${label}_clean_R2_in_R2.fastq.gz ${TEMP}/${label}_clean_R2_in_R1.fastq.gz > ${OUTPUT}/${label}_clean_processed_R2.fastq.gz


