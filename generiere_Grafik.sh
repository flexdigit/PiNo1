#!/bin/bash
# Generiert 4 Grafik für 4 Temperatursensoren (Sensor 1, 2, 3, 4)
# Grafik tempday.png:	Temperaturen inne und außen
# Grafik tempweek.png:	Temperaturen inne und außen
# Grafik solarday.png:	Temperaturen Vor- und Rücklauf der Solaranlage
# Grafik solarweek.png:	Temperaturen Vor- und Rücklauf der Solaranlage

# Wechsle ins Verzeichnis mit Datenbank und .digitemprc
#cd /home/pi/temperature

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

######################
# Generiere index.htm
######################
HTMLPAGE="/home/pi/temperature/index.htm"

echo "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">" > $HTMLPAGE
echo "<html>"                           >> $HTMLPAGE
echo "<head>"                           >> $HTMLPAGE
echo "    <title>No. 1 | flexdigit</title>"			>> $HTMLPAGE
echo "</head>"                          >> $HTMLPAGE
echo "No. 1 | "                         >> $HTMLPAGE
#echo "<br>"                             >> $HTMLPAGE
date '+%a %Y-%m-%d %H:%M'               >> $HTMLPAGE
echo "    <p></p>"                      >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo "    <img src="http://flexdigit.cwsurf.de/tempday.png">"		>> $HTMLPAGE
echo "    <img src="http://flexdigit.cwsurf.de/tempweek.png">"		>> $HTMLPAGE
echo "    <img src="http://flexdigit.cwsurf.de/solarday.png">"		>> $HTMLPAGE
echo "    <img src="http://flexdigit.cwsurf.de/solarweek.png">"	    >> $HTMLPAGE
echo ""                                 >> $HTMLPAGE
echo "    <img src="http://flexdigit.cwsurf.de/image.jpg">"         >> $HTMLPAGE
echo "	  <p></p>"                      >> $HTMLPAGE
uptime                                  >> $HTMLPAGE
echo "	  <p></p>"                      >> $HTMLPAGE
echo "<font size="4" face="Courier"><pre>" >> $HTMLPAGE
df -h |  tr '\n' '#' | sed 's/#/<br>/g' >> $HTMLPAGE
echo "	  <p></p>"                      >> $HTMLPAGE
#du -sh /home/pi/temperature/flexdigit.github.com/.git/ >> $HTMLPAGE
vcgencmd measure_temp					>> $HTMLPAGE
vcgencmd measure_volts					>> $HTMLPAGE
vcgencmd measure_clock arm				>> $HTMLPAGE
echo "</pre></font>"                    >> $HTMLPAGE
echo "</html>"                          >> $HTMLPAGE

##########################################
# Kopiere die Skripte für den commit
##########################################
cp /home/pi/temperature/gettemp.sh           /home/pi/temperature/flexdigit.github.com
cp /home/pi/temperature/generiere_Grafik.sh  /home/pi/temperature/flexdigit.github.com
cp /home/pi/temperature/index.htm            /home/pi/temperature/flexdigit.github.com

#########################
# commite sie auf github
#########################
#cd /home/pi/temperature/flexdigit.github.com
#git add .
#git commit -a -m `date +%s`
#git push origin

#############################################################
# FTP-Skripte ausführen um Bilder auf www.cwcity.de zu laden
#############################################################
cd /home/pi/temperature/
./cwcity_FTP.sh
#/home/pi/temperature/cwcity_FTP.sh

date "+%Y.%m.%d | %H:%M:%S"

# fuer crontab
# */5 * * * * $HOME/temperature/generiere_Grafik.sh >> $HOME/temperature/generiere_Grafik.log 2>&1

