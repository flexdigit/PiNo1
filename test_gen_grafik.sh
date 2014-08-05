#!/bin/bash

RRDPATH="/home/pi/temperature/"


#################
# Tagesdiagramme
#################
rrdtool graph $RRDPATH/test-temp.png                \
  -s 'now - 1 day' -e 'now'                         \
  --vertical-label "Air temp. [°C]"                 \
  --title "Day (inside/outside)"                    \
  --watermark "© $(/bin/date +%Y) flexdigit"        \
  DEF:temp2=$RRDPATH/temperature.rrd:temp2:AVERAGE	\
  DEF:temp3=$RRDPATH/temperature.rrd:temp3:AVERAGE	\
  COMMENT:"     "                                   \
  LINE1:temp2#F000F0:"inside "                      \
  GPRINT:temp2:LAST:"Current\: %4.1lf %s"           \
  GPRINT:temp2:MIN:"Min.\: %4.1lf %s"               \
  GPRINT:temp2:MAX:"Max.\: %4.1lf %s\n"             \
  COMMENT:"     "                                   \
  LINE1:temp3#000000:"outside"                      \
  GPRINT:temp3:LAST:"Current\: %4.1lf %s"           \
  GPRINT:temp3:MIN:"Min.\: %4.1lf %s"               \
  GPRINT:temp3:MAX:"Max.\: %4.1lf %s\n"             \
  COMMENT:"Generated $(/bin/date "+%a %d.%m.%Y | %H\:%M\:%S")\c"
  
  
  