#!/bin/bash

startdate=2017-11-08
enddate=$(date -v -1d "+%Y-%m-%d")
# $(date -v -1d "+%Y-%m-%d")

sDateTs=`date -j -f "%Y-%m-%d" $startdate "+%s"`
eDateTs=`date -j -f "%Y-%m-%d" $enddate "+%s"`
dateTs=$sDateTs
offset=86400

while [ "$dateTs" -le "$eDateTs" ]
do
  date=`date -j -f "%s" $dateTs "+%Y%m%d"`
  printf '%s\n' $date
  curl "https://www.crimemapping.com/Map/CrimeIncidents_Read?paramFilt=%7B%22SelectedCategories%22%3A%5B%221%22%2C%222%22%2C%223%22%2C%224%22%2C%225%22%2C%226%22%2C%227%22%2C%228%22%2C%229%22%2C%2210%22%2C%2211%22%2C%2212%22%2C%2213%22%2C%2214%22%2C%2215%22%5D%2C%22SpatialFilter%22%3A%7B%22FilterType%22%3A2%2C%22Filter%22%3A%22%7B%5C%22rings%5C%22%3A%5B%5B%5B-13044783.487538977%2C4141593.6023566034%5D%2C%5B-13044783.487538977%2C4157014.772813117%5D%2C%5B-13009565.126756629%2C4157014.772813117%5D%2C%5B-13009565.126756629%2C4141593.6023566034%5D%2C%5B-13044783.487538977%2C4141593.6023566034%5D%5D%5D%2C%5C%22spatialReference%5C%22%3A%7B%5C%22wkid%5C%22%3A102100\}\}%22\}%2C%22TemporalFilter%22%3A%7B%22PreviousID%22%3A%224%22%2C%22PreviousNumDays%22%3A28%2C%22PreviousName%22%3A%22Previous%204%20Weeks%22%2C%22FilterType%22%3A%22Previous%22%2C%22ExplicitStartDate%22%3A%22$date%22%2C%22ExplicitEndDate%22%3A%22$date%22\}%2C%22AgencyFilter%22%3A%5B%2221%22%5D\}&unmappableOrgIDs=System.Collections.Generic.List%601%5BSystem.Int32%5D" -H 'Origin: https://www.crimemapping.com' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.139 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: */*' -H 'Referer: https://www.crimemapping.com/map/agency/21' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive' -H 'DNT: 1' --data 'sort=&page=1&pageSize=1000&group=&filter=' --compressed | jq -c '.Data[] | {description: .Description, incidentNumber: .IncidentNum, location: .Location, agency: .Agency, date: .Date }' >> barstowCACrimes.json
  dateTs=$(($dateTs+$offset))
done
