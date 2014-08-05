#!/bin/bash

# FTP
FTP_SERVER=flexdigit.bplaced.net
FTP_USER=flexdigit
FTP_PW=gebuit00_Zaka2

cd .

ftp -n -v $FTP_SERVER << EOT
user $FTP_USER $FTP_PW
bin
prompt
mput index.htm
mput *.png
by
EOT

