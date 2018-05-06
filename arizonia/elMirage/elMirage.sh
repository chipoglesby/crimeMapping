#!/bin/bash

startdate=$(date -v -1d "+%Y-%m-%d")
enddate=$(date -v -1d "+%Y-%m-%d")
# date "+%Y-%m-%d"

sDateTs=`date -j -f "%Y-%m-%d" $startdate "+%s"`
eDateTs=`date -j -f "%Y-%m-%d" $enddate "+%s"`
dateTs=$sDateTs
offset=86400

while [ "$dateTs" -le "$eDateTs" ]
do
  date=`date -j -f "%s" $dateTs "+%Y%m%d"`
  printf '%s\n' $date
  jq -c '.Data[] | {description: .Description, incidentNumber: .IncidentNum, location: .Location, agency: .Agency, date: .Date }' >> elMirageAZCrimes.json
  dateTs=$(($dateTs+$offset))
done
