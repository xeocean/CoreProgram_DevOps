#!/bin/bash

select_color() {
    local color
    case $1 in
    1) color="\e[37m" ;;
    2) color="\e[31m" ;;
    3) color="\e[32m" ;;
    4) color="\e[34m" ;;
    5) color="\e[35m" ;;
    6) color="\e[30m" ;;
    esac

    case $2 in
    1) color+="\e[47m" ;;
    2) color+="\e[41m" ;;
    3) color+="\e[42m" ;;
    4) color+="\e[44m" ;;
    5) color+="\e[45m" ;;
    6) color+="\e[40m" ;;
    esac
    echo -e "$color"
}