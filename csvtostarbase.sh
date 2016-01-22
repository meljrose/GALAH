
# grab the id, ra, and dec columns of galah data 
# and translate it to a starbase table


# for jeffrey's input catalog
## go from fits to ascii w/ stilts tcopy
stilts tcopy ifmt=fits ofmt=csv in=galah_input_cat.fits out=galah_input_cat.csv
cat galah_input_cat.csv | cut -d, -f1 -f5 -f10 -f11 > reducedgal.csv
# sort based on RA
sort -t, -k3 -n reducedgal.csv > jsortedgal.csv


# for gayandhi's input catalog
cat galahic_1m_inf.csv | cut -d, -f2 -f3 -f4 -f7 > reducedgal.csv
sort -t, -k2 -n galahic_1m_inf.csv > gsortedgal.csv




# CONVERT TO STARBASE

# count the number of headers
head -n 1 reducedgal.csv > count.csv
n=$(sed 's/[^,]//g' count.csv | wc -c)

# change from csv to tab seperated
tab=$(printf -- "\t")
sed 's|,|'"$tab"'|g' reducedgal.csv > reducedgal.tbl

# write in "---" things

x=$(seq -s ' ' 2 $n)
dashes=$(printf -- "---\t%.0s" $x)"---"


sed '2s:^: '"$dashes"' \'$'\n:g' reducedgal.tbl > dashedgal.tbl

# delete temp files
rm count.csv reducedgal.csv reducedgal.tbl

# sort based on RA
sort -k2 -n dashedgal.tbl > sortedgal.tbl

