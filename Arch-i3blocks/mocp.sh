#!/bin/bash



# author: @hringriin
# not elegant, but it works
#mocp -S

if [[ $1 == "1" ]] ; then
    echo "prev"
    mocp -r
fi

if [[ $1 == "2" ]] ; then
    echo "toggle"
    mocp -G
fi

if [[ $1 == "3" ]] ; then
    echo "next"
    mocp -f
fi

Title=$(mocp -i | grep "^Title:" | cut -d ":" -f2 | sed -e 's/^ //g')
S_Title=$(echo -e "$Title" | head -c 40)
Status=$(mocp -i | grep "^State:" | cut -d ":" -f2)

if [ "$Status" == "STOP" ] ; then
    echo -e " : STOP"
elif [ "$Status" != " PLAY" ];then
    echo -e " : Pause"
else
    echo -e " : $S_Title ... "
fi
