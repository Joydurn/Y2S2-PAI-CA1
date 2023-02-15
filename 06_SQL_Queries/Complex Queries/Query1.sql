USE Taxi_Trip 

SELECT 
   d.driver_id as 'Driver ID',
   d.name as 'Name',
   YEAR(d.date_of_birth) as 'Birth Year',
   DATEDIFF(hour,d.date_of_birth,GETDATE())/8766 as 'Age',
   d.gender as 'Gender',
   d.car_model as 'Car Model',
   d.car_make_year as 'Car Make Year',
   d.rating as 'Rating out of 5',
   SUM(CASE WHEN sl.label=1 THEN 1 ELSE 0 END) as 'Dangerous Trips',
   COUNT(DISTINCT sl.booking_id) as 'Total Trips',
   FORMAT(CAST(SUM(CASE WHEN sl.label=1 THEN 1 ELSE 0 END) AS float)/ CAST(COUNT(sl.label) AS float),'P') as '% Dangerous Trips',
   CONVERT(DECIMAL(10,2),AVG(s.Speed)) as 'Avg Speed (m/s)',
   CONVERT(DECIMAL(10,2),MAX(s.Speed)) as 'Max Speed (m/s)',
   CONVERT(DECIMAL(10,2),AVG(s.Acceleration)) as 'Avg Acceleration (m/s^2)',
   CONVERT(DECIMAL(10,2),MAX(s.Acceleration)) as 'Max Acceleration (m/s^2)',
   CONVERT(DECIMAL(10,2),AVG(s.Gyro)) as 'Avg Gyro (radians)',
   CONVERT(DECIMAL(10,2),MAX(s.Gyro)) as 'Max Gyro (radians)' 
FROM 
   dataLake.drivers d
   LEFT JOIN dataLake.safety_labels sl ON sl.driver_id = d.driver_id
   INNER JOIN 
      (SELECT 
         booking_id,
         AVG(speed) 'Speed',
         -- calculating total acceeleration magnitude 
         AVG(
            SQRT(SQUARE(acceleration_x)+
            SQUARE(acceleration_y)+
            SQUARE(acceleration_z))
         ) 'Acceleration',
         -- calculating total gyro magnitude 
         AVG(
            SQRT(SQUARE(gyro_x)+
            SQUARE(gyro_y)+
            SQUARE(gyro_z))
         ) 'Gyro',
         AVG(bearing) 'Bearing',
         AVG(accuracy) 'Accuracy'
      FROM dataLake.sensor GROUP BY booking_id) s ON s.booking_id = sl.booking_id 
GROUP BY 
   d.driver_id,d.name,d.date_of_birth,d.gender,d.car_model,d.car_make_year,d.rating
ORDER BY 
   '% Dangerous Trips' DESC,
   'Dangerous Trips' DESC






