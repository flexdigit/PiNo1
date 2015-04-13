#!/bin/bash

# FTP
FTP_SERVER=flexdigit.cwsurf.de
FTP_USER=usr_ftp_216891
FTP_PW=gebuit00_Zaka2

#cd .

#ftp -n -v $FTP_SERVER << EOT
ftp -n $FTP_SERVER << EOT
user $FTP_USER $FTP_PW

bin
prompt

cd /htdocs
mput tempday.png
mput solarday.png
mput tempweek.png
mput solarweek.png
mput day_graph.png
mput week_bars.png
mput year_bars.png

mput index.htm

by
EOT

