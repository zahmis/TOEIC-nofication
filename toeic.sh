#!/bin/bash
set -eu

START=`date +%s`
END=`(date --date '2022/05/29' +%s)`
isAfter=$((END < START))

restSeconds=0
if(($isAfter)) then
 restSeconds=START - END
else
 restSeconds=END - START
fi

slackData () {
  diffDays="$((${restSeconds} / (60 * 60 * 24)))"
  if(($isAfter)) then
  text="TOEIC から ${diffDays} 日経過"
  else
  text="TOEIC まで ${diffDays} 日"
  fi
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

