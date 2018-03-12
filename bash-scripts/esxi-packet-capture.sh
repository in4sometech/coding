#!/bin/bash

echo "please enter servername"
read servername
echo -e "please enter the Nic number which had issue, Ex \e[32m eth0 for first nic on VM\e[0m or \e[32meth1 for second\e[0m or eth2 for third nic"
read vlan
echo $servername $vlan
worldid=$(esxcli network vm list | egrep -Ei $servername| awk '{print $1;}')
echo "World id is $worldid"
esxcli network vm port list -w $worldid | cat >> /tmp/$servername-dvs-nic-report.txt
switchport=$(net-stats -l | egrep -Ei $servername.$vlan | awk '{print $1;}')
echo -e "dvs switchport is \e[32m$switchport\e[0m"
macid=$(net-stats -l | egrep -Ei $servername.$vlan | awk '{print $5;}')
vmnicport=$(esxcli network vm port list -w $worldid | grep -A 2 -B 4 -i $macid | awk '/Uplink/{print $3;}')
echo -e "Macid fo the traffic capture in scope is \e[32m$macid\e[0m"
echo -e "Vmnic port in use for the Vm is \e[32m$vmnicport\e[0m"
if [ "$switchport" = "" ]
then
echo -e "\e[44m Failed, please provide correct Servername and eth number\e[0m"
exit 1
else
trap "stopping the capture and exiting the program" INT
echo -e "\e[44m Packet Capture in progress on Dvport and VMNic's, pleasee use CTRL+C to stop the capture\e[0m" &
#To capture all traffic using Dv-Switch port
pktcap-uw --switchport $switchport --dir 0 --stage 0 -o /tmp/stage-0-at-switch-port-dir-0.pcap &
pktcap-uw --switchport $switchport --dir 0 --stage 1 -o /tmp/stage-1-at-switch-port-dir-0.pcap &
pktcap-uw --switchport $switchport --dir 1 --stage 0 -o /tmp/stage-0-at-switch-port-dir-1.pcap &
pktcap-uw --switchport $switchport --dir 1 --stage 1 -o /tmp/stage-1-at-switch-port-dir-1.pcap &

#To capture all traffic using VMnic Port

pktcap-uw --uplink $vmnicport --dir 1 --stage 0 -o /tmp/stage-0-at-$vmnicport-dir-1.pcap &
pktcap-uw --uplink $vmnicport --dir 1 --stage 1 -o /tmp/stage-1-at-$vmnicport-dir-1.pcap &
pktcap-uw --uplink $vmnicport --dir 0 --stage 0 -o /tmp/stage-0-at-$vmnicport-dir-0.pcap &
pktcap-uw --uplink $vmnicport --dir 0 --stage 1 -o /tmp/stage-1-at-$vmnicport-dir-0.pcap

#pktcap-uw --uplink vmnic1 --dir 1 --stage 0 -o /tmp/stage-0-at-vmnic1-dir-1.pcap -Uncomment and change vmnic number to capture all traffic on other nic

exit 1
fi
