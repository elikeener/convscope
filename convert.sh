#!/bin/bash

indir=$1
filename=$2
rootname=$3
convertdir=$(pwd)

if [ -d ${indir}txt ]
then
echo "${indir}txt exits"
else
  mkdir -p ${indir}txt 
fi

outdir=${indir}txt

# Create paf file
cat > $(pwd)/paf << EOF
-sel      ${filename}.*                           # 
-inp      ${indir}
-otp      ${outdir}
-fli      fff
# index extraction for each dimension
# -pai <pattern>  1st dim
# -pai <pattern>  2nd dim
# and so on
# each pattern must contain 3 groups ()()()
# the index is the content of the group in the middle
# -pai      "(img9X)(\d+\.*\d*)(.+)"       # 1st index 
#-pai      "${filename}(\d)(\.wfm)"       # 1st index 
-pai      "${filename}b(\d+)_(\d+)v_Ch(\d)(\.wfm)"       # 1st index 

# -pai      "(img9X58Y25_CH)(\d)(.+)"         # 2nd index - channel number
-ili      iii
# the tem parameter can be a literal string or a regex
# the program will do a regex replacement of the tem parameter with
# the indices inserted in places that match the patterns for the indices
# given by -pai
# if the index is 26.5 and the pattern in pai was (\d+\.*\d*)
# then 00.0 also matches that pai pattern, and 26.5 is inserted in its
# place
# 
-tem      ${filename}.wfm
-nff      1000
# -crf      crf
-hea      hea
-lts      ttt
-dia      y                             # diagnostic information
-fff      fff
EOF

#Run wfmextract.cc
./wfmextract -paf paf

echo "Combining data files >> ${filename}.fff"
echo "This may take a few minutes"
cat ${outdir}/*Ch1*.fff > ${outdir}/${filename}_CH1.txt
cat ${outdir}/*Ch2*.fff > ${outdir}/${filename}_CH2.txt
cat ${outdir}/*Ch3*.fff > ${outdir}/${filename}_CH3.txt
cat ${outdir}/*Ch4*.fff > ${outdir}/${filename}_CH4.txt
paste ${outdir}/${filename}_CH*.txt > ${outdir}/${rootname}_allCH.txt
#echo "Combining data files >> ${filename}.lts"
#cat ${outdir}/*.wfmCH1*.lts > ${outdir}/${filename}_wfmCH1.lts
#cat ${outdir}/*.wfmCH2*.lts > ${outdir}/${filename}_wfmCH2.lts
#cat ${outdir}/*.wfmCH3*.lts > ${outdir}/${filename}_wfmCH3.lts
#cat ${outdir}/*.wfmCH4*.lts > ${outdir}/${filename}_wfmCH4.lts
#paste ${outdir}/${filename}_wfmCH*.lts > ${outdir}/${rootname}_root.lts
echo "Cleaning..."
#rm ${outdir}/*wfmCH*
echo "Copying to analysis directory"
cp ${outdir}/*_allCH* ${convertdir}
cd ${convertdir}
echo "Completed!"

