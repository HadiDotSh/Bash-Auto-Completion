#!/bin/bash
# By @HadiDotSh

text="This
auto completion
is
working
well"

trap bye INT
function bye() {
    printf "\r\033[2K"
    exit 0
}

while IFS= read -rsn 1 input
do
    # Pressing enter
    if [[ ${input} == $'\0' ]];then
        printf "\r\033[2K"
        printf "\e[1;0m${match}"
        exit 0

    # Pressing delete key
    elif [[ ${input} == $'\177' ]];then
        word="${word%?}"

    else
        word="${word}${input}"

    fi
    match=$( printf "${text}" | grep --ignore-case -m1 "^${word}" )
    printf "\r\033[2K"
    printf "\e[1;0m${word:0:${#word}}\e[1;90m${match:${#word}}"
done
