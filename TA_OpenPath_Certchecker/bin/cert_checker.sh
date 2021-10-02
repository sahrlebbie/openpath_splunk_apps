#! /bin/bash

#This script was created to check the certs of websites listed in the lookups portion of this TA.
                                ###### The website must use SSL. #######
#Be sure to edit the websites.csv with your websites you want to check web expirations for.
	#Also be sure to separate the website and the port with a ":"..example openpathus.com:443
#This script aslo requires openssl and whatever dependencies it needs. Be sure to check for errors by looking in the error logs. 

#SPLUNK_HOME="/opt/splunk"
#URL_FILE_PATH="$SPLUNK_HOME/etc/TA_OpenPath_Certchecker/lookups/"
SPLUNK_HOME="/Applications/Splunk"
URL_FILE_PATH="$SPLUNK_HOME/etc/apps/TA_OpenPath_Certchecker/lookups/"
FILE_NAME="websites.csv"

for WEBSITE in $(cat $URL_FILE_PATH$FILE_NAME)
do
URL=$(echo $WEBSITE |awk -F ':' '{print $1}')
PORT=$(echo $WEBSITE |awk -F ':' '{print $2}')
echo "`date` The website, $URL running on $PORT expires:"
echo "Q" |openssl s_client -connect $URL:$PORT -servername https://${URL} 2> /dev/null | openssl x509 -noout -enddate
done
