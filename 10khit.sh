#!/bin/bash

echo ""
echo "[STARTED SURFING]"

SUM=0
for i in {1..1000}
do
    OUTPUT=$(source curl.sh)
    
    TAG=$(echo $OUTPUT | grep -o '<h4><i class="fa fa-exchange"></i>.*</h4>')

    POINTS=$(echo "$TAG" |  sed -E 's/<h4><i class="fa fa-exchange"><\/i> (.*)<\/h4>/\1/');
    
    [[ -z $POINTS ]] && continue

    NUM=$(echo $POINTS | grep -Eo '([0-9]+\.[0-9]+)|([0-9])')

    SCRIPT=$(echo $OUTPUT | grep -E -o '<script(.*)<\/script>');

    DELAY=$(echo $SCRIPT | grep -E 'setTimeout(.*)' | grep -E -o '}, \d\d\d\d+' | grep -E -o "\d+" );


    SUM=$(echo $SUM + $NUM | bc -l)

    echo -ne "\033[2K\r ✅ TOTAL POINTS: $SUM | 😴 $(($DELAY / 1000)) sec"

    sleep $(($DELAY / 1000))

done
