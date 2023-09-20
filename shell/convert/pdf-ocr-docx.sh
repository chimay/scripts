#!/bin/sh

# convert pdf containing images to text using ocr

pdffile=$1
head=${pdffile%.*}

echo "pdftoppm $pdffile $head -png"
pdftoppm $pdffile $head -png

for pngfile in $head-*.png
do
	pnghead=${pngfile%.*}
	echo "tesseract $pngfile $pnghead --dpi 150"
	tesseract $pngfile $pnghead --dpi 150
done

textfile=$head.txt

echo "cat $head-*.txt > $textfile"
cat $head-*.txt > $textfile

# convert text to docx with pandoc

docxfile=$head.docx

echo "pandoc -t docx $textfile > $docxfile"
pandoc -t docx $textfile > $docxfile
