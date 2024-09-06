#!/bin/bash
# append user's ssh key to authorized_keys
# Usage: append_user_ssh_key.sh [-u [user]][ssh_key]
# if no user is provided, it will default to the current user
# and is current user is superuser, it will show error log and exit
# if no ssh key is provided, it will show usage and exit

USAGE="Usage: append_user_ssh_key.sh [-u [user]][ssh_key]"

if [ $# -eq 0 ]; then
    echo "No ssh key provided"
    echo "$USAGE"
    exit 1
fi

# argument parsing
while [ $# -gt 0 ]; do
    case "$1" in
        -u)
            if [ -z "$2" ]; then
                echo "No user provided"
                echo "$USAGE"
                exit 1
            fi
            USER="$2"
            shift 2
            ;;
        *)
            SSH_KEY="$1"
            shift
            ;;
    esac
done

# if no user is provided, default to the current user
if [ -z "$USER" ]; then
    USER=$(whoami)
fi

# if current user is superuser, show error log and exit
if [ "$USER" == "root" ]; then
    echo "Cannot append ssh key to superuser"
    exit 1
fi

# if no ssh key is provided, show usage and exit
if [ -z "$SSH_KEY" ]; then
    echo "No ssh key provided"
    echo "$USAGE"
    exit 1
fi

# append ssh key to authorized_keys
echo "$SSH_KEY" >> /home/$USER/.ssh/authorized_keys
echo "Appended ssh key to /home/$USER/.ssh/authorized_keys"
