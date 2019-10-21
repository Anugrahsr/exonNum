#!/bin/bash
echo " "
echo " "
echo "###################################################################"
echo "	        	 ExonNum: Exon Number Finder v.1                "
echo "	        	                    made with <3 by AnugrahSR   "
echo "###################################################################"

FILE=Homo_sapiens.GRCh38.98.gtf
if [ ! -f $FILE ]; then
    
#Download the gtf file from ensembl
wget ftp://ftp.ensembl.org/pub/release-98/gtf/homo_sapiens/Homo_sapiens.GRCh38.98.gtf.gz

#extract using gunzip
gunzip Homo_sapiens.GRCh38.98.gtf.gz
fi
#extracting gene ID and Exon Number
awk '$3=="exon" {print $0}' Homo_sapiens.GRCh38.98.gtf | awk '{ count[$10]++ } END { for (word in count) print word, count[word]}' > geneID_exon

sed 's/"//g' geneID_exon|sed 's/;//g' > GeneID_Exon
rm geneID_exon
echo "Gene ID and Exon number saved to file : GeneID_Exon"

echo "##################################################################"

read -p "Enter Exon  number:" number
echo " "
echo " "
echo "Gene ID for "$number" exonic genes saved in "$number"_exonGeneID"
grep -w "$number" GeneID_Exon|awk '{print $1}' > "$number"_exonGeneID
echo " "
echo " "
echo "#################################################################"
echo "From biomart find the corresponding gene Name"
#https://www.ensembl.org/biomart

#Getting gene name corresponding to gene ID
for i in `cat "$number"_exonGeneID`; do grep "$i" gene; done > "$number"_GeneList

echo " "
echo "Gene list with "$number" exon [[saved]] "$number"_GeneList "
echo "#################################################################"

