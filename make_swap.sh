#!/bin/sh


if [ `free | tail -n 1 | awk '{print $2}'` -gt 0 ]; then
    echo "Swap found.";
else
    echo -n "Create swap file: "
    if [ ! -e "/root/swaper" ]; then
        dd if=/dev/zero of=/root/swaper bs=64k count=16384
        chmod 600 /root/swaper
    fi
    if [ "$?"=="0" ]; then
        echo "OK"
        echo "Active swap: "
        mkswap /root/swaper && swapon /root/swaper
        if [ "$?"=="0" ]; then
            echo "OK"
            echo "/root/swaper swap swap defaults 0 0" >> /etc/fstab
        else
            echo "failed."
        fi
    else
        echo "failed."
    fi
fi
