#!/bin/bash

for process in `ls /proc | grep -o '[0-9]*'`; do
    stat_info="`sudo ls /proc/$process/fd/0 >/dev/null 2>&1 && sudo realpath /proc/$process/fd/0`"
    if echo $stat_info | grep -q "/dev/null"
    then stat_info="?"
    fi
    if [ -n "$stat_info" ]
    then stat_info="?"
    fi
    if  [ -f /proc/$process/stat ]
    then stat=`cat /proc/$process/stat | awk '{print $3; }'`
    fi
    if [ -f /proc/$process/cmdline ]
    then 
    	cmdline=`sudo cat /proc/$process/cmdline`
		if [ ! -n "$cmdline" ]
    	then
    		cmdline=`cat /proc/$process/stat | awk '{print $2; }'`
    	fi
    else
        cmdline=""
    fi
    
    if [ -f /proc/$process/stat ] && [ -f /proc/$process/cmdline ]
    then
    timer=`awk '{ print $14+$15;}' /proc/$process/stat`
    printf "$process \t $stat_info \t $stat \t $timer \t $cmdline"
    fi


    #echo "$process `sudo ls /proc/$process/fd/0 >/dev/null 2>&1 && sudo realpath /proc/$process/fd/0 || echo "?"` `cat /proc/$process/stat | awk '{print $3; }'`  `sudo cat /proc/$process/cmdline`";
done