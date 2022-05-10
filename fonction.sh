#!/bin/bash

function verifier_ext(){
	read -p "donner votre fichier :" filee
	filename=$(basename -- "$filee")
	extension="${filename##*.}"
	filename="$filename"
		case $extension in 
			"c")
				ext=1;
				echo "$filename est un fichier C"
				;;
			*)
				echo "Le fichier $filename n'est pas un fichier C "
		esac
}


saisie(){
	echo "- saisir le fichier : "
	read filee
	verif_ext
}


function verifier_fichier(){
	read -p "donner votre fichier :" filee
	if [[ -f "$filee" ]]; 
	then 
	exist=1
	fi
}

#verifier_fichier

show_usage(){
	echo " usage :  compiler.sh: [-h] [-v] [-m] [-g] [-w] [-d] [-o] [-c] [-s] [-p] chemin ... "
}

afficher_helpp() {
	cat help.txt 
}
export -f afficher_helpp


cmdmain=(
   yad
   --center --width=400
   --image="gtk-dialog-info"
   --title="YAD interface graphique"
   --text="select an option."
   --button="Exit":1
   --form
        --field="Help  ":btn "bash -c afficher_helpp"  
        --field="Version et auteurs ":btn "bash -c afficher_auteurs" 
	--field="afficher_proprietes ":btn "bash -c afficher_proprietes filee" 
	--field="Debug ":btn "bash -c debug $2" 
	--field="Warni ":btn "bash -c warni" 
	--field="Optim ":btn "bash -c optim" 
	--field="Compiler ":btn "bash -c compiler" 
	--field="supprimer ":btn "bash -c supprimer"
)

########fonction ouvre fenetre yad
interface_graphique(){
    while true; do
        "${cmdmain[@]}"
        s=$?
        case $s in
            1|252) break;;
        esac
    done
}


function afficher_menutxt(){
	PS3="Votre choix :"
	echo "***Menu***"
	   select item in "- Help -" "- Version et auteurs -" "- Touch -"  "- Debug -" "- Warni -" "- Optim -" "- Compiler -" "- Clean -" "- Quitter -"
	       do
			case $REPLY in
				1)
					echo "$item"
					afficher_helpp
					;;
				2)
					echo "$item"
					afficher_auteurs
					;;
				3)
					echo "$item"
					saisie
					afficher_proprietes
					;;
				4)
					echo "$item"
					saisie
					debug
					;;
				5)
					echo "$item"
					saisie
					warni
					;; 
				6) 
					echo "$item"
					saisie
					optim
					;; 
				7) 
					echo "$item"
					saisie
					compiler
					;; 
				8)
					echo "$item"
					saisie
					supprimer
					;;
				9)
					echo "$item"
					exit 0
					;;
				*)
					echo "- Choix Incorrect !  "
					;;
			esac
	done
}

function debug(){
	read -p "donner votre fichier :" filee
	#verifier_ext
	exist=0
	verif_fichier
	filename=$(basename -- "$filee")
	extension="${filename##*.}"
	filename="$filename"
	len=`expr length $filename`
	filename=${filename:0:$len-2}
	case $exist in 
		1)
			gcc  $filee -g -o $filename
			echo "succes"
			;;
		*) 
			echo "le fichier est introuvable "
	esac
}

function compiler(){        
	read -p "donner votre fichier :" filee 
	#verifier_ext
	exist=0
	verifier_fichier
	filename=$(basename -- "$filee")
	extension="${filename##*.}"
	filename="$filename"
	len=`expr length $filename`
	filename=${filename:0:$len-2}
	case $exist in 
		1)
			gcc $filee -c 
			echo "succes"
			;;
		*) 
			echo "le fichier est introuvable "
	esac
}

function warni(){
	read -p "donner votre fichier :" filee
	#verifier_ext
	exist=0
	verifier_fichier
	case $exist in 
		1)
			gcc $filee -Wall -W
			echo "succes"
			;;
		*) 
			echo "le fichier est introuvable "
	esac
}

function optim(){
	read -p "donner votre fichier :" filee
	#verifier_ext
	exist=0
	verifier_fichier
	case $exist in 
		1)
			gcc $filee -O2
			echo "succes"
			;;
		*) 
			echo "le fichier est introuvable "
	esac
}

function afficher_proprietes(){
	read -p "donner votre fichier :" filee
	#verifier_ext
	verifier_fichier
	case $exist in 
		1)
			filename=$(basename -- "$filee")
			extension="${filename##*.}"
			filename="$filename"
			len=`expr length $filename`
			filename=${filename:0:$len-2}
			echo "le nom de fichier : $filename"
			date=$(stat -c %y $filee)
			echo "Date de modification : $date"
			;;
		*)
			echo "le fichier est introuvable "
	esac
}

function supprimer(){
	read -p "donner votre fichier :" filee
	#verifier_ext
	exist=0
	verifier_fichier
	filename=$(basename -- "$filee")
	extension="${filename##*.}"
	filename="$filename"
	len=`expr length $filename`
	filename=${filename:0:$len-2}
	case $exist in 
		1)
			rm $filename
			echo "le fichier $filename est supprimée "
			;;
		*)
			echo "le fichier est introuvable "
	esac
}

afficher_auteurs(){
	echo "Auteurs : Ahmed Maaouia et kheireddine Bouzazi"
	echo "Version : 0.1"
}

  export -f afficher_auteurs 
  export -f afficher_proprietes  
  export -f debug
  export -f warni
  export -f optim
  export -f compiler
  export -f supprimer
