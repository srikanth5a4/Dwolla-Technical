#!/bin/sh

INPUT=$1
OUTPUT="$INPUT.json"
S3URL=$2

echo "{\"flowlog\":[" > $OUTPUT
grep "REJECT" $INPUT|awk 'NR > 1 { printf(",") } {print "{\"datetime\":\""$1"\",\"version\":\""$2"\",\"account\":\""$3"\",\"eni\":\""$4"\",\"source\":\""$5"\",\"destination\":\""$6"\",\"srcport\":\""$7"\",\"destport\":\""$8"\",\"protocol\":\""$9"\",\"packets\":\""$10"\",\"bytes\":\""$11"\",\"windowstart\":\""$12"\",\"windowend\":\""$13"\",\"action\":\""$14"\"}" }' >> $OUTPUT
echo "]}" >> $OUTPUT

echo "Number of Rejected entries:" >> $OUTPUT
tr -s ' ' '\n' < $OUTPUT | grep REJECT | wc -l >> $OUTPUT
aws s3 cp $OUTPUT $S3URL

