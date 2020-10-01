#!/bin/bash -e
# ju 10-Aug-20

# Git versionieren

# Variablen
#------------------------------------------------------
	THEMA="Notizen-TeX-Web" # = REPOSITORY
	repos_USB="/media/jan/usb/repos/notizenUbuntu"    
	repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#------------------------------------------------------

info="Git versionieren"
git_file="git-log.txt"
timestamp=$(date +"%d-%h-%Y")  # 11-Aug-2020
copyright="ju $timestamp $git_file"

echo "+ $info"

#----------------------------------------------------------
# Voraussetzung:
# (1) lokales Repository: master
	# anpassen 
#git init # rm -rf .git
#git add .
#git commit -m"Projekt init"

# (2) Github Repository:  origin/master
	# anpassen    
#git remote add origin https://github.com/ju1-eu/Vektorgrafiken-SVG-EPS.git
#git push -u origin master

# (3) backup Repository:  backupUSB/master
    # anpassen
#repos_USB="/media/jan/usb/repos/notizenUbuntu"    
#REPOSITORY="Vektorgrafiken-SVG-EPS"
#LESEZEICHEN="backupUSB"
#git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY.git 
#git remote add $LESEZEICHEN $repos_USB/$REPOSITORY.git 
#git push --all $LESEZEICHEN

# (4)  Backup Repository: backupHD/master
    # anpassen
#repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#REPOSITORY="Vektorgrafiken-SVG-EPS"
#LESEZEICHEN="backupHD"
#git clone --no-hardlinks --bare . $repos_HD/$REPOSITORY.git 
#git remote add $LESEZEICHEN $repos_HD/$REPOSITORY.git 
#git push --all $LESEZEICHEN
#----------------------------------------------------------

# Git-Version
# lokales Repository: HEAD -> master
#
# usereingabe
read -p "lokales Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# lokales Repository: HEAD -> master
	git add .
	git commit -a # editor
	echo "# ------------------------"
	echo $copyright > $git_file
	git lg >> $git_file  # version anlegen
	echo "# ------------------------"
else
	# beenden
	echo "Ende: $antwort"
fi

# Github Repository: origin/master
#
# usereingabe
read -p "Github Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# Github Repository: origin/master
	git push
	echo "# ------------------------"
else
	# beenden
	echo "Ende: $antwort"
fi

# Backup Repository: backupHD/master
#
# usereingabe
read -p "Backup Repository $repos_HD vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# Fehler: String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# Speicher - Laufwerk vorhanden?
	if [ ! -d $repos_HD ]; then
		echo "$repos_HD mounten."
	else
		# Backup Repository
		LESEZEICHEN="backupHD"
		git push --all $LESEZEICHEN 
		echo "# ------------------------"
	fi
else
	# beenden
	echo "Ende: $antwort"
fi

# Backup Repository: backupUSB/master
#
# usereingabe
read -p "Backup Repository $repos_USB vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
	# Fehler: String ist leer
	echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
	# Speicher - Laufwerk vorhanden?
	if [ ! -d $repos_USB ]; then
		echo "$repos_USB mounten."
	else
		# Backup Repository
		LESEZEICHEN="backupUSB"
		git push --all $LESEZEICHEN 
		echo "# ------------------------"
	fi
else
	# beenden
	echo "Ende: $antwort"
fi

echo "# ------------------------"
git status
git lg
echo "# ------------------------"

echo "fertig"
