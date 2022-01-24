#!/bin/bash
set -eu

START=`date +%s`
END=`(date --date '2023/02/27' +%s)`
restSeconds=$((END-START))

slackData () {
  restDays="$((${restSeconds} / (60 * 60 * 24)))"
  cat <<EOF
{
    "blocks": [
        {
            "type": "section",
            "text": {
                "type": "mrkdwn",
                "text": "TOEIC までのこり ${restDays}日"
            }
         }
    ]
}
EOF
}

TOKEN_GENE="nUF9Jp7JrWK30VvL0z6SggPy"

curl -X POST -H 'Content-type: application/json' --data "$(slackData)" https://hooks.slack.com/services/T02633YV1GW/B02R6HYP4LT/${TOKEN_GENE}

