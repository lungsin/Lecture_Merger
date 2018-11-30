# Format in std input:
# <namepdf>.pdf <pages separated by space>
# example: 
# Lecture1.pdf 10 12 13 20-25  

id=0
merge=""
while read i; do
	id=`expr $id + 1`
	f_name=$(echo $i | cut -d" " -f1-1)
	pages=$(echo $i | cut -d" " -f2-)
	echo " $id => processing $f_name with pages $pages"
	pdftk $f_name cat $pages output tmp$id.pdf
	merge=$(echo "$merge tmp$id.pdf")
done

pdftk $merge output out.pdf
pdfnup --nup 2x4 --suffix 'nup' --no-landscape --frame true --scale 0.95 --batch out.pdf
rm tmp*
