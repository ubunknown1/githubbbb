#!/bin/sh


change_mac() {
	iface=$(iw dev | awk '/Interface/ {interf=$2} END {print interf}')
	currentmac=$(cat /sys/class/net/$iface/address)
	sudo service NetworkManager stop
	sleep 1
	sudo macchanger -r "$iface" | tail -n 1 | sed 's/  //g'
	sleep 1
	sudo service NetworkManager restart
	newmac=$(cat /sys/class/net/$iface/address)
	echo "$newmac"
        if [ "$checkmac" = "$newmac" ]; then
        	echo "something went wrong"
                echo "Mac Address Is NOT Spoofed!"
                echo "Fix the Problem Now!"
        else
        	clear
                echo "Mac Address is successfully Changed"
                echo ""
                echo "old Mac Address is $currentmac"
                echo "new Mac Address is $newmac"
	fi
}

change_mac
