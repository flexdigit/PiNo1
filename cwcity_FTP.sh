#!/bin/bash

# FTP
FTP_SERVER=flexdigit.cwsurf.de
FTP_USER=usr_ftp_216891
FTP_PW=gebuit00_Zaka2

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

