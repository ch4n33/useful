#!/bin/bash

# toggle or switch between GUI and CLI in Ubuntu
# -t or --toggle: toggle between GUI and CLI
# -s [on|off] or --switch [on|off]: switch to GUI or CLI
# Usage: toggle_or_switch_ubuntu_gui.sh [-t|--toggle] [-s|--switch [on|off]]
# if no option is provided, it will show usage and exit
# if both -t and -s are provided, it will show usage and exit

# argument parsing
USAGE="Usage: toggle_or_switch_ubuntu_gui.sh [-t|--toggle] [-s|--switch [on|off]]"
if [ $# -eq 0 ]; then
    echo "No option provided"
    echo "$USAGE"
    exit 1
fi

if [ $# -eq 1 ]; then
    if [ "$1" == "-t" ] || [ "$1" == "--toggle" ]; then
        # toggle between GUI and CLI
        if [ "$(systemctl get-default)" == "graphical.target" ]; then
            sudo systemctl set-default multi-user.target
            echo "Switched to CLI"
        else
            sudo systemctl set-default graphical.target
            echo "Switched to GUI"
        fi
    else
        echo "Invalid option"
        echo "$USAGE"
        exit 1
    fi
elif [ $# -eq 2 ]; then
    if [ "$1" == "-s" ] || [ "$1" == "--switch" ]; then
        if [ "$2" == "on" ]; then
            sudo systemctl set-default graphical.target
            echo "Switched to GUI"
        elif [ "$2" == "off" ]; then
            sudo systemctl set-default multi-user.target
            echo "Switched to CLI"
        else
            echo "Invalid option"
            echo "$USAGE"
            exit 1
        fi
    else
        echo "Invalid option"
        echo "$USAGE"
        exit 1
    fi
else
    echo "Too many options provided"
    echo "$USAGE"
    exit 1
fi