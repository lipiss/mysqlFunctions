DROP FUNCTION IF EXISTS f_Distance;
--/
CREATE FUNCTION f_Distance
        (
            lat1 FLOAT,
            lon1 FLOAT,
            lat2 FLOAT,
            lon2 FLOAT) RETURNS FLOAT
        BEGIN DECLARE dLonRad, dLatRad, a, c, ecc2, earthRadius, dist FLOAT;
SET dLonRad = RADIANS(lon2 - lon1);
SET dLatRad = RADIANS(lat2 - lat1);
SET a = POW(SIN(dLatRad/2),2) + COS(RADIANS(lat1)) * COS(RADIANS(lat2)) * POW(SIN(dLonRad/2),2);
SET c = 2 * ATAN2(SQRT(a), SQRT(1-a));
SET ecc2 = POW(0.081082,2);
SET earthRadius = (6378 * SQRT(1 - ecc2)) / (1 - (ecc2 * POW(SIN(RADIANS(lat1)), 2)));
SET dist = earthRadius * c;
RETURN dist;
END;
/
