#!/bin/sh

# This script is used to write "LOW BAT" to a file once
# the battery charge drops below 20%.
# I use a cronjob to run this script every minute,
# and a custom zsh theme to display the content of
# the file ~/.batstat.txt in my prompt.
# This way I'll notice a low battery even without having
# to check the OS X status bar.
# 
# This is the custom prompt:
# 
# PROMPT='%? %{$fg_bold[red]%}%m%{$reset_color%}:%{$fg[cyan]%}%c%{$reset_color%}:%# '
# RPROMPT='%{$fg_bold[red]%}$(command cat ~/.batstat.txt)%{$reset_color%}%{$fg_bold[green]%} $(git_prompt_info)%{$reset_color%} '

IOREG=/usr/sbin/ioreg
Max=`${IOREG} -rc AppleSmartBattery | grep -e MaxCapacity | tr -s " " : | cut -d":" -f4`
Current=`${IOREG} -rc AppleSmartBattery | grep -e CurrentCapacity | tr -s " " : | cut -d":" -f4`
# echo Max: ${Max}
# echo Current: ${Current}
Charge=$((100*$Current/$Max))
# echo ${Charge}
Text=
if [[ $Charge -le 20 ]]; then
    Text="\#[bg=red]\#[blink,fg=red,bg=default]  LOW BAT \#[noblink,bg=red,fg=default]\#[bg=default]"
else
    if   [[ $Charge -le 20 ]]; then Text=""
    elif [[ $Charge -le 30 ]]; then Text=""
    elif [[ $Charge -le 40 ]]; then Text=""
    elif [[ $Charge -le 50 ]]; then Text=""
    elif [[ $Charge -le 60 ]]; then Text=""
    elif [[ $Charge -le 70 ]]; then Text=""
    elif [[ $Charge -le 80 ]]; then Text=""
    elif [[ $Charge -le 90 ]]; then Text=""
    elif [[ $Charge -le 99 ]]; then Text=""
    else                            Text=""
    fi
fi

printf "${Text}" > /Users/moritz/.batstat.txt
