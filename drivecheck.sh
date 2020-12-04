#!/bin/bash
trm='*: '
user='root' #specify the user account which you set up the SSH keys for
k='192.168.0.' #specify the first 3 octets. assuming all servers are in the same network !!keep the trailing '.'
for j in 10 12 14 16 18 20 22 24 #assuming all servers are on the same local network, we just need to specify the last octet for each server here
do
	for i in {0..13} #assuming each server has 12 drives -eventually I will make this dynamic
	do
		shout=`ssh $user@$k$j '/opt/dell/srvadmin/bin/omreport storage pdisk controller=0 pdisk=0:0:'$i' | grep "State"'`
		shim=${shout##$trm}
		if [ "$shim" != "Online" ]
			then
				if [ "$shim" == "Rebuilding" ]
					then
						shout=`ssh $user@$k$j '/opt/dell/srvadmin/bin/omreport storage pdisk controller=0 pdisk=0:0:'$i' | grep "Progress"'`
						shim=${shout##$trm}
						echo "server $j drive $i is rebuilding, progress is $shim" >> /root/drivereport.txt
				else
					echo "server $j drive $i is state $shim" >> /root/drivereport.txt
				fi
		fi
		shout=`ssh root@$k$j '/opt/dell/srvadmin/bin/omreport storage pdisk controller=0 pdisk=0:0:'$i' | grep "Failure Predicted"'`
		shim=${shout##$trm}
		if [ "$shim" == "Yes" ]
			then
				echo "server $j drive $i is predicted failure" >> /root/drivereport.txt
		fi
	done
done

if [ -e /root/drivereport.txt ]
	then
		touch /root/activealert.txt
		filename='/root/drivereport.txt'
		while read p; do 
			/root/discord-notify.sh "$p"
		done < $filename
		#mail -s "drive report" alerts@example.com < /root/drivereport.txt #if you want the report emailed
		mv /root/drivereport.txt /root/drivereport/$(date +%F-%T)_drivereport.txt
else
	if [ -e /root/activealert.txt ]
		then
			/root/discord-notify.sh "alerts cleared"
			rm /root/activealert.txt
	fi
fi
