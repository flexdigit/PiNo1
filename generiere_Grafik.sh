#!/bin/bash
# Generiert 4 Grafik für 4 Temperatursensoren (Sensor 1, 2, 3, 4)
# Grafik tempday.png:	Temperaturen inne und außen
# Grafik tempweek.png:	Temperaturen inne und außen
# Grafik solarday.png:	Temperaturen Vor- und Rücklauf der Solaranlage
# Grafik solarweek.png:	Temperaturen Vor- und Rücklauf der Solaranlage

RRDPATH="/home/pi/temperature"

#################
# Tagesdiagramme
#################
# Temperatur inside/outside
rrdtool graph $RRDPATH/tempday.png                  \
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

# Solar
rrdtool graph $RRDPATH/solarday.png                 \
  -s 'now - 1 day' -e 'now'                         \
  --vertical-label "Solar temp. [°C]"               \
  --title "Day (flow/return)"                       \
  --watermark "© $(/bin/date +%Y) flexdigit"        \
  DEF:temp0=$RRDPATH/temperature.rrd:temp0:AVERAGE	\
  DEF:temp1=$RRDPATH/temperature.rrd:temp1:AVERAGE	\
  COMMENT:"     "                                   \
  LINE1:temp0#00FF00:"flow  "                       \
  GPRINT:temp0:LAST:"Current\: %4.1lf %s"           \
  GPRINT:temp0:MIN:"Min.\: %4.1lf %s"               \
  GPRINT:temp0:MAX:"Max.\: %4.1lf %s\n"             \
  COMMENT:"     "                                   \
  LINE1:temp1#0000FF:"return"                       \
  GPRINT:temp1:LAST:"Current\: %4.1lf %s"           \
  GPRINT:temp1:MIN:"Min.\: %4.1lf %s"               \
  GPRINT:temp1:MAX:"Max.\: %4.1lf %s\n"             \
  COMMENT:"Generated $(/bin/date "+%a %d.%m.%Y | %H\:%M\:%S")\c"
  
##################
# Wochendiagramme
##################
# Temperatur inside/outside
rrdtool graph $RRDPATH/tempweek.png --start -1w		\
  --vertical-label "Air temp. [°C]"                 \
  --title "Week (inside/outside)"                   \
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

# Solar
rrdtool graph $RRDPATH/solarweek.png --start -1w	\
  --vertical-label "Solar temp. [°C]"               \
  --title "Week (flow/return)"                      \
  --watermark "© $(/bin/date +%Y) flexdigit"        \
  DEF:temp0=$RRDPATH/temperature.rrd:temp0:AVERAGE	\
  DEF:temp1=$RRDPATH/temperature.rrd:temp1:AVERAGE	\
  COMMENT:"     "                                   \
  LINE1:temp0#00FF00:"flow  "                       \
  GPRINT:temp0:LAST:"Current\: %4.1lf %s"           \
  GPRINT:temp0:MIN:"Min.\: %4.1lf %s"               \
  GPRINT:temp0:MAX:"Max.\: %4.1lf %s\n"             \
  COMMENT:"     "                                   \
  LINE1:temp1#0000FF:"return"                       \
  GPRINT:temp1:LAST:"Current\: %4.1lf %s"           \
  GPRINT:temp1:MIN:"Min.\: %4.1lf %s"               \
  GPRINT:temp1:MAX:"Max.\: %4.1lf %s\n"             \
  COMMENT:"Generated $(/bin/date "+%a %d.%m.%Y | %H\:%M\:%S")\c"


#############################################################
# FTP-Skripte ausführen um Grafiken auf www.cwcity.de zu laden
#############################################################
cd /home/pi/temperature/
./cwcity_FTP.sh
#/home/pi/temperature/cwcity_FTP.sh

date "+%Y.%m.%d | %H:%M:%S"

# fuer crontab
# */5 * * * * $HOME/temperature/generiere_Grafik.sh >> $HOME/temperature/generiere_Grafik.log 2>&1

