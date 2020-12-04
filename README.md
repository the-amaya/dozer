<p align="center">
	<img alt="GitHub language count" src="https://img.shields.io/github/languages/count/the-amaya/dozer?style=plastic">
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/the-amaya/dozer?style=plastic">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/the-amaya/dozer?style=plastic">
	<img alt="GitHub" src="https://img.shields.io/github/license/the-amaya/dozer?style=plastic">
	<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/the-amaya/dozer?style=plastic">
	<img alt="GitHub last commit" src="https://img.shields.io/github/last-commit/the-amaya/dozer?style=plastic">
</p>

# dozer

dozer is a simple script used to monitor the drive health status on dell servers.


## Requirements

To use this script you will need to configure SSH key pairs between the server this script is running on and all servers it is checking.
You will also need to have dell openmanage installed on the servers. This script assumes it is available here: ```/opt/dell/srvadmin/bin/omreport```


## Setup

once the above requirements are met you will need to edit drivecheck.sh to specify the server IPs you want to check (currently just a list of 4th octets, can easily be adjusted)
you will also need to specify the user account to be used. You need to ensure it has permissions to use the omreport command.

By default, the script is configured to send a discord webhook using discord-notify.sh, you will need to add your webhook url to it
You can also send an email notice (there is a commented spot near the end of drivecheck.sh where you can specify the email address and uncomment the command)

Once you have verified the sript is able to ssh to servers and run the omreport command you can add this to your cron jobs to run at whatever interval you prefer. I have it configured hourly
