#!/bin/bash
shopt -s extglob

cat m.1_*.aggregrated.report.txt | cut -f5 > rowlabel1.tmp
cat m.1_*.aggregrated.report.txt | cut -f4 > rowlabel2.tmp
cat m.1_*.aggregrated.report.txt | cut -f6 > rowlabel3.tmp

echo -en "TaxonomyID\tCode\tTaxonomy" > resultsTableHeader.tmp
paste rowlabel1.tmp rowlabel2.tmp rowlabel3.tmp > krakenAggregrateResultTable.tmp


for file in *.aggregrated.report.txt ; do
	sn=$(basename $file .aggregrated.report.txt)
	sn=${sn#.m}
	echo -en "\t$sn" >> resultsTableHeader.tmp
	cat $file | cut -f2 > $sn.count.tmp
	paste krakenAggregrateResultTable.tmp $sn.count.tmp > krakenAggregrateResultTable.another.tmp
	mv krakenAggregrateResultTable.another.tmp krakenAggregrateResultTable.tmp
	head krakenAggregrateResultTable.tmp
done

echo -en "\n" >> resultsTableHeader.tmp	

cat resultsTableHeader.tmp krakenAggregrateResultTable.tmp > krakenAggregrateResultTable.txt

rm *.tmp
