#!/bin/bash
echo "" > subdomains_temp.txt
echo "" > IPs_temp.txt
echo "" > scanning_temp.txt
echo -e "\n"
echo "         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
echo "         ********************EaseScan v 0.1**********************"
echo "         ********************************************************"
echo "         *-*-*-*- Recon and Vulnerability Analysis Tool  -*-*-*-" 
echo "         --------------------------------------------------------"
echo "         ********************************************************"
echo "         *****************Author: @Protector47*******************"
echo "         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-"
echo -e "\n"

echo "Find Subdomains, Open Ports, Poodle and Heartbleed Vulnerable Domains:"
echo "Enter the URL without HTTP/HTTPS:"
echo -e "\n"
read url
echo -e "\n"

echo "         ********************************************************"
echo "         *****************SUBDOMAINS SCANNING START**************"
echo "         ********************************************************"

echo -e "\n"

dnsmap $url -r ./subdomains_temp.txt
cat subdomains_temp.txt | grep IP | awk -F " " '{print $4}' > IPs_temp.txt

echo -e "\n"
echo "         *********************************************************"
echo "         ******************PORTS SCANNING START*******************"
echo "         *********************************************************"

echo -e "\n"

nmap -p U:53,111,137,T:21-25,80,139,443,8080,S:9 -iL IPs_temp.txt > scanning_temp.txt
cat scanning_temp.txt
echo "" > subdomains_temp.txt
echo "" > scanning_temp.txt

echo -e "\n"

echo "         *********************************************************"
echo "         **********************POODLE SCANNING START**************"
echo "         *********************************************************"




nmap --script ssl-poodle -p 443 -iL IPs_temp.txt > scanning_temp.txt
cat scanning_temp.txt
echo "" > subdomains_temp.txt
echo "" > scanning_temp.txt
echo -e "\n"


echo "         *********************************************************"
echo "         ******************HEARTBLEED SCANNING START**************"
echo "         *********************************************************"

nmap -p 443 --script ssl-heartbleed -iL IPs_temp.txt > scanning_temp.txt
cat scanning_temp.txt

echo "" > subdomains_temp.txt
echo "" > IPs_temp.txt
echo "" > scanning_temp.txt
echo -e "\n"

echo "         ********************GOOD LUCK*************************"
