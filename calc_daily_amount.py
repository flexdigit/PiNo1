#!/usr/bin/python

import time, sqlite3, datetime

#--------------------------------------------------------------------
# New database Gasmeter.db should contain two tables with the following
# columns:
#   - dailyamount     (amount, tstamp)
#   - gascounter      (tick, tstamp)
#--------------------------------------------------------------------

# connect and create record cursor
connection = sqlite3.connect("/home/pi/GPIO/Gasmeter.db")
#connection = sqlite3.connect("Gasmeter.db")
cursor = connection.cursor()

# Query values from yesterday
#sql = "SELECT SUM(tick), tstamp FROM gascounter WHERE tstamp > date('now', '-1 days') AND tstamp <  date('now')"
sql = "SELECT SUM(tick), tstamp FROM gascounter WHERE tstamp BETWEEN DATE('now', '-1 days') AND DATE('now')"
cursor.execute(sql)

for dsatz in cursor:
    print "dsatz:",dsatz[0], "for yesterday:", dsatz[1], "| Data generated:",time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))

# write summarized values from yesterday into table "dailyamount"
sql = 'INSERT INTO dailyamount (amount,tstamp) VALUES(?,?)'
args = (dsatz[0],dsatz[1])
#args = (dsatz[0],yesterday)
cursor.execute(sql, args)

# never forget this, if you want the changes to be saved
connection.commit()

# Verbindung beenden
connection.close()


