#!/usr/bin/bash

###########################
###
### Author: Yuriy Kuzin
###
############################

kbmodel="pc105"

declare -a kblayoutsarr=( 'us,ua' 'pl,cz' 'de,us' )
declare -a kbvariantsarr=( ',winkeys' ',' ',' )
declare -a kboptionsarr=( 'grp:ctrl_shift_toggle,eurosign:e,lv3:ralt_switch' 'grp:ctrl_shift_toggle' 'grp:ctrl_shift_toggle' )
declare -a vislayoutsarr=( 'US UA' 'PL CZ' 'DE US' )

echo "Groups: ${#kblayoutsarr[@]}"

currentlayout="$(setxkbmap -query|grep layout|awk -F':' {'gsub(/[ \t]+/, "", $2); print $2'})"
if [ -z $1 ]; then
    arrid=0
else
    arrid=$((${#kblayoutsarr[@]}-1))
fi
for i in "${kblayoutsarr[@]}"; do
    echo "layout group id: $arrid"
    echo "layouts val: ${kblayoutsarr[$arrid]}"
    echo "variants: ${kbvariantsarr[$arrid]}"
    echo "options: ${kboptionsarr[$arrid]}"
    echo "visual: ${vislayoutsarr[$arrid]}"
    cur=${kblayoutsarr[$arrid]}
    grpid=$((arrid+1))
    if [ -z $1 ]; then
	if [ $grpid != ${#kblayoutsarr[@]} ]; then
	    ((arrid++));
	else
	    arrid=0
	fi
    else
	if [ $grpid != 1 ]; then
	    ((arrid--));
	else
	    arrid=$((${#kblayoutsarr[@]}-1));
	fi
    fi
    
    if [ -z ${kbvariantsarr[$arrid]} ]; then
	variantcmd=""
    else
	variantcmd="-variant"
    fi
    if [ $currentlayout  == "$cur" ]; then
	echo "Changing group to $grpid: ${vislayoutsarr[$arrid]}"
	setxkbmap -option
	setxkbmap -layout ${kblayoutsarr[$arrid]} $variantcmd ${kbvariantsarr[$arrid]} -option ${kboptionsarr[$arrid]}
	notify-send -t 1500 -i keyboard "Keyboard Group $(($arrid+1)): ${vislayoutsarr[$arrid]}"
	break
    fi
done

firstlaunch=1
for i in "${kblayoutsarr[@]}"; do
    if [ $currentlayout  == "$i" ]; then
	firstlaunch=0
    fi
done

if [ $firstlaunch -eq 1 ]; then
    if [ -z ${kbvariantsarr[0]} ]; then
	variantcmd=""
    else
	variantcmd="-variant"
    fi
    echo "Setting up keyboar layout"
    setxkbmap -option
    setxkbmap -layout ${kblayoutsarr[0]} $variantcmd ${kbvariantsarr[0]} -option ${kboptionsarr[0]}
fi

exit 0
