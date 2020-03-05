#!/bin/bash
webook_url="##webook_url##"
clamd_log="/opt/local/var/log/clamav/clamd.log"
onaccess_log="/opt/local/var/log/clamav/clamdscanonaccess.log"
search_word="FOUND"
prev_hash=""
prev_date=0
pidfile="/opt/local/var/run/clamav/clamdalert.pid"

sample_action() {
  while read i
  do
    found=`echo ${i} | grep "${search_word}"`
    if [ -n "${found}" ]; then
      info=`echo ${found} | tr "(" " " | tr ")" " " | sed "s/[^:a-zA-Z0-9\/ :\-\.\[\]]/_/g"`
      info=(${info//,/ })
      malware_name=${info[1]}
      hash=(${info[2]//:/ })
      hash=${hash[0]}
      if [ $((`date +%s`)) -gt $((prev_date+5)) -o "$hash" != "$prev_hash" ]; then
        echo $malware_name
        echo $hash
        path=`grep ${malware_name} ${onaccess_log} | tail -n 1 | sed "s/:.*$//"`
        echo $path
        prev_hash=$hash
        prev_date=`date +%s`
        curl -sS -X POST --data-urlencode "payload={
          \"username\": \"malware alert\", \
          \"icon_emoji\": \":imp:\", \
          \"attachments\":[ \
              { \
                \"pretext\":\"${malware_name} was detected.\", \
                \"color\":\"#D00000\", \
                \"fields\":[ \
                    { \
                      \"title\":\"Name\", \
                      \"value\":\"${malware_name}\", \
                      \"short\":true \
                    }, \
                    { \
                      \"title\":\"Host\", \
                      \"value\":\"`hostname`\", \
                      \"short\":true \
                    }, \
                    { \
                      \"title\":\"IP\", \
                      \"value\":\"`ipconfig getifaddr en0`\", \
                      \"short\":true \
                    }, \
                    { \
                      \"title\":\"Date\", \
                      \"value\":\"`date`\", \
                      \"short\":true \
                    }, \
                    { \
                      \"title\":\"hash\", \
                      \"value\":\"<https://www.virustotal.com/gui/file/${hash}/detection|${hash}>\", \
                      \"short\":false \
                    } \
                ] \
              } \
          ] \
        }" ${webook_url} > /dev/null
      fi
    fi
  done
}
if [ -f ${pidfile} ]; then
	/usr/bin/kill `cat ${pidfile}` > /dev/null
  /bin/rm -f ${pidfile}
fi
echo $$ > ${pidfile}
tail -n 0 -F ${clamd_log} | sample_action
exit
