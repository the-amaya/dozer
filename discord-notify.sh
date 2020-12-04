#!/bin/bash
message="$@"
## format to parse to curl
## echo Sending message: $message
msg_content=\"$message\"

## discord webhook
url='https://discord-webhook-url-to-send-alerts-to'
curl -H "Content-Type: application/json" -X POST -d "{\"content\": $msg_content}" $url
