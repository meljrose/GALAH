# grab the id, ra, and dec columns of galah data 
# and translate it to a starbase table

# grab only certain columns
cat galahic_1m_inf.csv | cut -d, -f2 -f3 -f4 > reducedgal.csv

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

