#!/bin/bash
# By @HadiDotSh

text="This
auto completion
is
working
well"

i=1
while IFS= read -rsn 1 char
do

    # When you press enter
    if [[ ${char} == $'\0' ]];then
        
        autoCompletion="${word}$(echo "${text}" | grep --ignore-case -m1 "^${word}" | cut -c ${i}-)"
        printf "\r${autoCompletion}\n"
        break
    
    fi

    # When you delete a letter
    if [[ ${char} == $'\177' ]];then
        word="${word%?}"
        if [[ $i != 1 ]];then
            let i--
        fi
    else
        word="${word}${char}";let i++
    fi
    
    tput el
    printf "\r\e[1;97m${word}"
    tput sc
    printf "\e[1;92m$(echo "${text}" | grep --ignore-case -m1 "^${word}" | cut -c ${i}-)"
    tput rc
done
