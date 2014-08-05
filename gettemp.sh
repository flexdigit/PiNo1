#!/bin/bash
# Hole Temperaturwerte von den Sensoren und speichere sie in RR Datenbank
#

# Pfad zu digitemp
DIGITEMP=/usr/bin/digitemp_DS9097

# DS (Data Sources) Namen der vorhandenen Sensoren
SENSORS=temp0:temp1:temp2:temp3

# Wechsle ins Verzeichnis mit Datenbank und .digitemprc
cd /home/pi/temperature

data=`$DIGITEMP -a -q -o 2 | awk 'NF>1 {OFS=":"; $1="N"; print}'`
if [ -n "$data" ] ; then
        rrdtool update temperature.rrd -t $SENSORS $data
fi

# Test um zu sehen was wie formatiert in die Datenbank geschrieben wird:
# /usr/bin/digitemp_DS9097 -a -q -o 2 | awk 'NF>1 {OFS=":"; $1="N"; print}'
# sieht so aus: N:23.56:22.94:22.12:13.38
#
# Der Aufruf:
# rrdtool update temperature.rrd -t $SENSORS $data
# sieht dann so aus:
# temp0:temp1:temp2:temp3 N:23.50:22.81:22.12:13.25