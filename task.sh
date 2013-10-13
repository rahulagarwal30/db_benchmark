#!/bin/sh
# Script to benchmark hk
# menu item
#
envr="staging01.healthkart.com"
while :
 do
    clear
    echo -e "\n-------------------------------------"
    echo "$(ifconfig | egrep 'inet ' | sed -e 's/inet //' -e 's/addr://' -e 's/ Bcast.*//' -e 's/127.*//')"
    echo " Main Menu  "
    echo "-------------------------------------"
    echo "[1] Start benchmarking number of queries at different pages"
    echo "[2] Display env"
    echo "[0] Exit/Stop"
    echo "======================="


   echo -n "Enter your menu choice [0-9]: "
    read yourch
    case $yourch in
      1) 


rm -f /root/benchmark/tmp_slow_query.log

cp /var/log/slow_query.log /root/benchmark/tmp_slow_query.log

echo "\n \n benchmarking for branch--> " | tee -a /var/log/bm.log
cd /usr/local/projects/rejuvenate/HKRejuvenate/;
git branch | grep "*" | tee -a /var/log/bm.log
echo "\n" | tee -a /var/log/bm.log
cd ~

#1
echo "" > /var/log/slow_query.log
curl --silent $envr > /dev/null

echo `date` | tee -a /var/log/bm.log
echo "benchmarking for -> " $envr | tee -a /var/log/bm.log

cat /var/log/slow_query.log | grep ';' | grep -iv "#\|set timestamp\|select 1\|select version()\|@@session.tx_isolation" | wc -l | tee -a /var/log/bm.log

#2
echo "" > /var/log/slow_query.log
curl --silent $envr/sports-nutrition/protein > /dev/null

echo `date` | tee -a /var/log/bm.log
echo "benchmarking for -> " $envr/sports-nutrition/protein | tee -a /var/log/bm.log

cat /var/log/slow_query.log | grep ';' | grep -iv "#\|set timestamp\|select 1\|select version()\|@@session.tx_isolation" | wc -l | tee -a /var/log/bm.log

#3
echo "" > /var/log/slow_query.log
curl --silent $envr/beauty/hair-care/shampoo > /dev/null

echo `date` | tee -a /var/log/bm.log
echo "benchmarking for -> " $envr/beauty/hair-care/shampoo | tee -a /var/log/bm.log

cat /var/log/slow_query.log | grep ';' | grep -iv "#\|set timestamp\|select 1\|select version()\|@@session.tx_isolation" | wc -l | tee -a /var/log/bm.log

#4
echo "" > /var/log/slow_query.log
curl --silent $envr/search?query=on > /dev/null

echo `date` | tee -a /var/log/bm.log
echo "benchmarking for -> " $envr/search?query=on  | tee -a /var/log/bm.log

cat /var/log/slow_query.log | grep ';' | grep -iv "#\|set timestamp\|select 1\|select version()\|@@session.tx_isolation" | wc -l | tee -a /var/log/bm.log


cp /root/benchmark/tmp_slow_query.log /var/log/slow_query.log


	
         echo "Press ENTER to continue" ; read pressEnter ;;
      2) echo "env is " $envr ; read pressEnter;;
      0) exit 0 ;;
      *) echo "Ooops!!! Please enter a valid value -------";
         echo -e "\nPress ENTER to continue" ; read pressEnter;;
 esac
done

