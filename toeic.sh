#!/bin/bash
set -eu

START=`date +%s`
END=`(date --date '2022/05/29' +%s)`
DEADLINEMORNING=`(date --date '2022/04/04' +%s)`
DEADLINEAFTERNOON=`(date --date '2022/04/11' +%s)`
isAfter=$((END < START)) # 0
# isAfter=$((END > START)) # 1

# restSeconds=$((isAfter && (START - END) || (END - START)))
if [ $isAfter -eq 1 ]; then
    restSeconds=$((START - END))
    diffDays="$((${restSeconds} / (60 * 60 * 24)))"
    text="TOEIC から ${diffDays} 日経過"
else
    restSeconds=$((END - START))
    restMorningDeadline=$((END - DEADLINEMORNING) / (60 * 60 * 24))
    restAfterNoonDeadline=$((END - DEADLINEAFTERNOON) / (60 * 60 * 24))
    diffDays="$((${restSeconds} / (60 * 60 * 24)))"
    text="TOEIC まで残り ${diffDays} 日 午前申し込み期限まで${restMorningDeadline} 日 午後申し込み期限まで${restAfterNoonDeadline} 日"
fi

echo $diffDays
echo $text

slackData () {
  diffDays=$diffDays
  text=$text
  cat <<EOF
{
    "blocks": [
        {
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": "${text}"
            }
         }
    ]
}
EOF
}

TOKEN_GENE="nUF9Jp7JrWK30VvL0z6SggPy"

curl -X POST -H 'Content-type: application/json' --data "$(slackData)" https://hooks.slack.com/services/T02633YV1GW/B02R6HYP4LT/${TOKEN_GENE}

