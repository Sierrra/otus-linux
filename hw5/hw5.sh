#!/bin/bash
LOCK=/var/tmp/initplock

if [ -f $LOCK ]; then
	echo Job is already running\!
	exit 6
fi
touch $LOCK
trap 'rm -f $LOCK; exit $?' INT TERM EXIT
from=$(cat /var/log/cron | grep test | sort | tail -1 | awk '{print $3}')
to=$(date '+%H:%M:%S')
echo  -e "Server requests stat from $from to $to\n" >> /tmp/cron_log_parse_stat_$from_$to.log
echo -e "TOP $1 IPs\n" >> /tmp/cron_log_parse_stat_$from_$to.log
awk '{print $1}' access.log | uniq -c | sort -n | tail -$1 >> /tmp/cron_log_parse_stat_$from_$to.log
echo -e "TOP $2 URLs\n"  >> /tmp/cron_log_parse_stat_$from_$to.log
awk '{print $7}' access.log | uniq -c | sort -n | tail -$2 >> /tmp/cron_log_parse_stat_$from_$to.log
echo -e "Errors\n" >> /tmp/cron_log_parse_stat_$from_$to.log
awk '(($9+0.0) > 400)' access.log >> /tmp/cron_log_parse_stat_$from_$to.log
echo -e "Response code stats\n" >> /tmp/cron_log_parse_stat_$from_$to.log
awk '{print $9}' access.log | sort | uniq -c | sort -rn >> /tmp/cron_log_parse_stat_$from_$to.log
cat /tmp/cron_log_parse_stat_$from_$to.log | mail -s "Stats from $from to $to" email@test.me
rm -f $LOCK
trap - INT TERM EXIT