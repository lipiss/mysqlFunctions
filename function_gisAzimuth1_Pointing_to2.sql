drop function if exists fAzimuth1_Pointing_To2;
--/
CREATE FUNCTION fAzimuth1_Pointing_To2
        (
            azimuth1 FLOAT,
            coordx FLOAT,
            coordy FLOAT,
            Bmwidth FLOAT,
            delta FLOAT
        ) RETURNS FLOAT
BEGIN
	/*
        DECLARE Bmwidth INTEGER DEFAULT 0;
	DECLARE coordy  INTEGER DEFAULT 0;
        */
DECLARE angle DOUBLE DEFAULT NULL;
SET angle= IF(coordx=0 AND coordy=0,
null, /* COSITE*/
IF(coordx=0, /* arcotg inf */
IF(coordy>0,0,180),    
IF((atan2(coordx,coordy)*180/pi()) >= 0,
(atan2(coordx,coordy)*180/pi()),
360+(atan2(coordx,coordy)*180/pi()))));
RETURN 
IF ( (azimuth1-(Bmwidth/2)-delta) < 0,
IF(((0 <= angle) AND (angle <= (azimuth1+(Bmwidth/2)+delta)))
OR (( (360+(azimuth1-(Bmwidth/2)-delta)) <= angle) AND (angle <= 360)), TRUE,FALSE),
IF( (azimuth1+(Bmwidth/2)+delta) > 360,
IF(((  (azimuth1-(Bmwidth/2)-delta) <= angle) AND (angle <= 360 ) )
OR ( (0 <= angle) AND (angle <= (azimuth1+(Bmwidth/2)+delta-360))  ), TRUE,FALSE),          
IF( ((azimuth1-(Bmwidth/2)-delta) <= angle) AND (angle <= (azimuth1+(Bmwidth/2)+delta)),TRUE, FALSE)));
END;
/
