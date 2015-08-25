#!/bin/bash
## echo $BASH_VERSION;
origPath=$GEDIT_CURRENT_DOCUMENT_URI;
## declare -a dirpath;
dirpath=();

if [[ $origPath == *"smb"* ]]
then
	IFS='/' read -a pathvars <<< $origPath;
	host=${pathvars[2]};

	cnt=0;
	count=${#pathvars[@]};

	for i in "${pathvars[@]}"
	do
		if (( $cnt > 2 ))
    then
    	if($cnt == $count-1)
    	then
    		dirpath[$cnt]=("${pathvars[$i]}");
    	else
    		dirpath[$cnt]=("${pathvars[$i]}/");
    	fi
    fi
    ((++$cnt));
	done

	## dirpath1=join / "${dirpath[@]}";
	join "/" ${dirpath};

	## finalPath="/run/user/1000/gvfs/smb-share:server=${host},share=$dirpath1";
	## echo $finalPath;
	echo -n $finalPath | xclip -sel clip;
else
	echo -n $origPath | xclip -sel clip;
fi

function join { local IFS="$1"; shift; echo "$*"; }
