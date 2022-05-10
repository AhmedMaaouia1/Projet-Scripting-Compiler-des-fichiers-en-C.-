#!/bin/bash 
source fonction.sh 
exist=0 
 
#ext=0

#verif_fichier


if [ $# -eq '0' ];then
   show_usage
exit
fi  

while getopts "hvmgdwospc" option
	do
		case $option in
			h)
				h=${OPTARG}
				afficher_helpp
				;; 
			v)
				v=${OPTARG} 
				afficher_auteurs
				;;
			m)
				m=${OPTARG}
				afficher_menutxt 
				;;
			g)
				g=${OPTARG}
				interface_graphique
				;; 
			d)
				d=${OPTARG} 
				debug 
				;;
			w)
				w=${OPTARG}
				warni 
				;;
			o)
				o=${OPTARG}
				optim 
				;;
			s)
				c=${OPTARG}
				supprimer 
				;;
			p)
				t=${OPTARG}
				afficher_proprietes 
				;;
			c)
				r=${OPTARG}
				compiler 
				;;
			*) 
				show_usage 
		esac 
	done
