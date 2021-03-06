#!/bin/bash -e
# ju 10-Aug-20

# index.html + pics.html erstellen

# Variable anpassen
THEMA="Notizen-TeX-Web"
css="css/github.css" # oder design.css
html="html"
file="index.html"
img="images"
GRAFIKEN="Grafiken"

info="index.html + pics.html erstellen."
timestamp=$(date +"%d-%h-%y") # 11-Aug-20
copyright="ju $timestamp"

echo "+ $info"

T1="<!DOCTYPE html>
<html><head>
	<meta charset=\"utf-8\"/>
	<title>$THEMA</title><!--anpassen-->
	<meta name=\"description\" content=\"Beschreibung\" />
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=yes\" />
	<style type=\"text/css\">
		code{white-space: pre-wrap;}
		span.smallcaps{font-variant: small-caps;}
		span.underline{text-decoration: underline;}
		div.column{display: inline-block; vertical-align: top; width: 50%;}
	</style>"

# index.html
T2="	<link rel=\"stylesheet\" href=\"./$css\" />"
# html/website.html
T3="	<link rel=\"stylesheet\" href=\"../$css\" />"
T4="</head><body><!-- Inhalt -->"
T5="</body></html>"

# File neu anlegen
# index.html
echo "<!--$copyright-->"  > $file
echo "$T1"               >> $file
echo "$T2"               >> $file
echo "$T4"               >> $file
echo "	<h1>$THEMA</h1>
	<!-- Navi -->
	<ul class=\"nav\">"  >> $file

#----------------------
# alle pics
pics="alle-pics.html"
echo "<!--$copyright-->"  > ./$html/$pics
echo "$T1"               >> ./$html/$pics
echo "$T3"               >> ./$html/$pics
echo "$T4"               >> ./$html/$pics
echo "	<p><a href=\"../$file\">Start</a></p>
	<h1>$THEMA</h1>
	<h2>alle Pics</h2>"  >> ./$html/$pics

cd $img

EXTENSION="webp" 
exist=$(find -iname "*.$EXTENSION" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.webp; do
		# Dateiname ohne Endung
		filename=`basename "$i" .webp` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi

EXTENSION="svg" 
exist=$(find -iname "*.$EXTENSION" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.svg; do
		# Dateiname ohne Endung
		filename=`basename "$i" .svg` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi

EXTENSION="jpg" 
exist=$(find -iname "*.$EXTENSION" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.jpg; do
		# Dateiname ohne Endung
		filename=`basename "$i" .jpg` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$img/$i\">
		<figure>
			<img class=scaled src=\"../$img/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi

cd ..

cd $GRAFIKEN

EXTENSION="svg" 
exist=$(find -iname "*.$EXTENSION" | wc -l)
n=1 # Pic Zaehler ((n+=1))
if [ $exist -ge 1 ]; then
	for i in *.svg; do
		# Dateiname ohne Endung
		filename=`basename "$i" .svg` # anpassen
		# html/alle-pics.html
		echo "	<!-- Abb. $n -->
		<p><a href=\"../$GRAFIKEN/$i\">
		<figure>
			<img class=scaled src=\"../$GRAFIKEN/$i\" alt=\"$filename\" style="width:60.0%">
			<figcaption>Abb. $n : $i</figcaption>
		</figure>
		</a></p>" >> ../$html/$pics
		((n+=1))
	done
fi


echo "+ $html/alle-pics.html wurde erstellt"

cd ..

echo "$T5"     >> ./$html/$pics

# -------------------------
# index.html
cd $html
for i in *.html; do
	# navi - index.html
	echo "		<li><a href=\"./$html/$i\">$i</a></li>"  >> ../$file
done
cd ..

echo "	</ul>" >> $file
echo "$T5"     >> $file

echo "+ index.html wurde erstellt"

echo "...fertig."
