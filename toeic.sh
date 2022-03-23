#!/bin/bash
set -eu

START=`date +%s`
END=`(date --date '2022/05/29' +%s)`
isAfter=$((END < START)) # 0
# isAfter=$((END > START)) # 1

# restSeconds=$((isAfter && (START - END) || (END - START)))
if [ $isAfter -eq 1 ]; then
    restSeconds=$((START - END))
    diffDays="$((${restSeconds} / (60 * 60 * 24)))"
    text="TOEIC まで残り ${diffDays} 日"
else
    restSeconds=$((END - START))
    diffDays="$((${restSeconds} / (60 * 60 * 24)))"
    text="TOEIC から残り ${diffDays} 日経過"
fi

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
                "text": ${text}
            }
         }
    ]
}
EOF
}

TOKEN_GENE="nUF9Jp7JrWK30VvL0z6SggPy"

curl -X POST -H 'Content-type: application/json' --data "$(slackData)" https://hooks.slack.com/services/T02633YV1GW/B02R6HYP4LT/${TOKEN_GENE}

