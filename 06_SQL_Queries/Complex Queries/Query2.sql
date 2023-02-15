USE Taxi_Trip

SELECT
CASE WHEN label=1 THEN 'Dangerous' ELSE 'Safe' END 'Label',
COUNT(label) 'Count',
CAST(AVG(speed) AS DECIMAL(10, 2)) 'Avg Speed',
CAST(MAX(speed) AS DECIMAL(10, 2)) 'Max Speed',
CAST(AVG(acceleration) AS DECIMAL(10, 2)) 'Avg Acceleration',
CAST(AVG(acceleration_x) AS DECIMAL(10, 2)) 'Avg Acceleration X',
CAST(AVG(acceleration_y) AS DECIMAL(10, 2)) 'Avg Acceleration Y',
CAST(AVG(acceleration_z) AS DECIMAL(10, 2)) 'Avg Acceleration Z',
CAST(MAX(acceleration) AS DECIMAL(10, 2)) 'Max Acceleration',
CAST(AVG(gyro) AS DECIMAL(10, 3)) 'Avg Gyro',
CAST(AVG(gyro_x) AS DECIMAL(10, 5)) 'Avg Gyro X',
CAST(AVG(gyro_y) AS DECIMAL(10, 5)) 'Avg Gyro Y',
CAST(AVG(gyro_z) AS DECIMAL(10, 5)) 'Avg Gyro Z',
CAST(MAX(gyro) AS DECIMAL(10, 2)) 'Max Gyro'
FROM dataLake.drivers d
   LEFT JOIN dataLake.safety_labels sl ON sl.driver_id = d.driver_id
   INNER JOIN 
      (SELECT 
         booking_id,
         AVG(speed) 'Speed',
         AVG(
            SQRT(SQUARE(acceleration_x)+
            SQUARE(acceleration_y)+
            SQUARE(acceleration_z))
         ) 'Acceleration',
		 AVG(acceleration_x) 'Acceleration_X',
		 AVG(acceleration_y) 'Acceleration_Y',
		 AVG(acceleration_z) 'Acceleration_Z',
         AVG(
            SQRT(SQUARE(gyro_x)+
            SQUARE(gyro_y)+
            SQUARE(gyro_z))
         ) 'Gyro',
		 AVG(gyro_x) 'Gyro_x',
		 AVG(gyro_y) 'Gyro_y',
		 AVG(gyro_z) 'Gyro_z',
         AVG(bearing) 'Bearing',
         AVG(accuracy) 'Accuracy'
      FROM dataLake.sensor GROUP BY booking_id) s ON s.booking_id = sl.booking_id 
GROUP BY label
ORDER BY 1 DESC;