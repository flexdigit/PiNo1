#!/bin/bash

# FTP
FTP_SERVER=flexdigit.cwsurf.de
FTP_USER=USER
FTP_PW=PW

#cd .

#ftp -n -v $FTP_SERVER << EOT
ftp -n $FTP_SERVER << EOT
user $FTP_USER $FTP_PW
cd /htdocs
bin
prompt
mput tempday.png
mput solarday.png
mput tempweek.png
mput solarweek.png
by
EOT

