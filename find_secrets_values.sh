# Script to List all available AWS secrets to a /tmp/name.text and find specific secret values from it
# Note needs AWS CLI configure to run this script successfully 

#!/bin/bash

aws secretsmanager list-secrets | grep  "Name" | awk '{print $2}' | tr -d '"' | sed 's/,/ /g' > /tmp/name.text
rm -rfv /tmp/secrets-values.txt
for line in `cat /tmp/name.text`
do

echo $line >> /tmp/secrets-values.txt

aws secretsmanager get-secret-value --secret-id "$line" | grep xyz >>  /tmp/secrets-values.txt
done
