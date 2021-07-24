#!/usr/bin/env bash
curl -X POST -H 'Content-type: application/json' --data '{"text":"Deleting cluster is starting"}' https://hooks.slack.com/services/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
kops delete cluster --name ${NAME} --yes

curl -X POST -H 'Content-type: application/json' --data '{"text":"Deleting cluster is complete"}' https://hooks.slack.com/services/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