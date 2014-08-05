#!/bin/bash

# FTP
FTP_SERVER=ftp-web.funpic.de
FTP_USER=ftp2008348
FTP_PW=gebuit00_Zaka3

cd .

ftp -n -v $FTP_SERVER << EOT
user $FTP_USER $FTP_PW
bin
prompt
mput index.htm
mput *.png
by
EOT

