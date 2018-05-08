/*CSV xxxx  toolkit -> https://csvkit.readthedocs.io/
How to create the table from the csv automatically:
From an a command prompt use the module csvsql
csvsql -i mysql sitefile.csv
*/
DROP TABLE IF EXISTS sitefile ;
CREATE TABLE sitefile (
        `Site ID` VARCHAR(8) NOT NULL,
        `Antenna ID` INTEGER NOT NULL,
        `Longitude` FLOAT NOT NULL,
        `Latitude` FLOAT NOT NULL,
        `Antenna File` VARCHAR(60) NOT NULL,
        `Height (m)` INTEGER NOT NULL,
        `Azimuth` INTEGER NOT NULL,
        `Mechanical Tilt` INTEGER NOT NULL,
        `Twist` INTEGER NOT NULL,
        `Donor Antenna` BOOL NOT NULL,
        `Terrain Height (m)` FLOAT NOT NULL,
        `Sectors` VARCHAR(72) NOT NULL,
        `Number of Corrections` INTEGER NOT NULL,
        `Correction (dB) at -180 degrees` INTEGER NOT NULL,
        `Correction (dB) at -150 degrees` INTEGER NOT NULL,
        `Correction (dB) at -120 degrees` INTEGER NOT NULL,
        `Correction (dB) at -90 degrees` INTEGER NOT NULL,
        `Correction (dB) at -60 degrees` INTEGER NOT NULL,
        `Correction (dB) at -30 degrees` INTEGER NOT NULL,
        `Correction (dB) at 0 degrees` INTEGER NOT NULL,
        `Correction (dB) at 30 degrees` INTEGER NOT NULL,
        `Correction (dB) at 60 degrees` INTEGER NOT NULL,
        `Correction (dB) at 90 degrees` INTEGER NOT NULL,
        `Correction (dB) at 120 degrees` INTEGER NOT NULL,
        `Correction (dB) at 150 degrees` INTEGER NOT NULL,
        CHECK (`Donor Antenna` IN (0, 1))
);


LOAD DATA LOCAL INFILE 
'c:\\Users\\EGARFEL\\Desktop\\\\sitefile.csv'
INTO TABLE sitefile fields TERMINATED BY '\t' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
