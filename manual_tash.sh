rm -f /root/benchmark/tmp_slow_query.log

cp /var/log/slow_query.log /root/benchmark/tmp_slow_query.log

echo "\n \n benchmarking with login for branch--> " | tee -a /var/log/bm.log
cd /usr/local/projects/rejuvenate/HKRejuvenate/;
git branch | grep "*" | tee -a /var/log/bm.log
echo "\n" | tee -a /var/log/bm.log
cd ~

#1

echo `date` | tee -a /var/log/bm.log
echo "benchmarking with login for for -> " $1 | tee -a /var/log/bm.log

cat /var/log/slow_query.log | grep ';' | grep -iv "#\|set timestamp\|select 1\|select version()\|@@session.tx_isolation" | wc -l | tee -a /var/log/bm.log

echo "" > /var/log/slow_query.log
