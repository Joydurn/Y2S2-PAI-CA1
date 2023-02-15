USE Taxi_Trip

SELECT
	d.car_model 'Car Model',
	COUNT(DISTINCT sl.booking_id) 'Number of Trips',
	FORMAT(CAST(SUM(CASE WHEN sl.label=1 THEN 1 ELSE 0 END) AS float)/ CAST(COUNT(sl.label) AS float),'P') as '% Dangerous Trips',
	CONVERT(DECIMAL(10, 2), MAX([Speed])) 'Max Speed',
	CONVERT(DECIMAL(10, 2), MAX([Acceleration])) 'Max Acceleration',
	CONVERT(DECIMAL(10, 2), AVG([Speed])) 'Avg Speed',
	RANK() OVER (ORDER BY AVG([Speed]) DESC) 'Avg Speed Ranking',
	CONVERT(DECIMAL(10, 2), AVG([Acceleration])) 'Avg Acceleration',
	CONVERT(DECIMAL(10, 2), AVG([Gyro])) 'Avg Gyro',
	CONVERT(DECIMAL(10, 2), AVG([Bearing])) 'Avg Bearing',
	CONVERT(DECIMAL(10, 2), AVG([Accuracy])) 'Avg Accuracy',
	-- AVG driver age
	CAST(AVG(CAST(
      DATEDIFF(hour,d.date_of_birth,GETDATE())/8766 AS DECIMAL(10, 2)
      ))AS DECIMAL(10, 2)) 'Avg Age',
	--AVG car age
	CAST(AVG(CAST(
	   YEAR(GETDATE())-YEAR(d.car_make_year) AS DECIMAL(10,2)
	   ))AS DECIMAL(10, 2)) 'Avg Car Age',
	CONVERT(DECIMAL(4, 2), AVG(d.rating)) 'Avg Rating',
	RANK() OVER (ORDER BY AVG(d.rating) DESC) 'Rating Ranking',
	FORMAT(CAST(SUM(CASE WHEN gender='Male' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) / CAST(COUNT(gender) AS DECIMAL(10, 2)),'P')  as '% Male'
FROM dataLake.drivers d
	LEFT JOIN dataLake.safety_labels sl ON sl.driver_id = d.driver_id
	INNER JOIN (SELECT 
					booking_id,
					AVG(speed) 'Speed',
					AVG(
						SQRT(SQUARE(acceleration_x)+
						SQUARE(acceleration_y)+
						SQUARE(acceleration_z))
         		) 'Acceleration',
					AVG(
						SQRT(SQUARE(gyro_x)+
						SQUARE(gyro_y)+
						SQUARE(gyro_z))
					) 'Gyro',
					AVG(bearing) 'Bearing',
					AVG(accuracy) 'Accuracy'
				FROM dataLake.sensor
				GROUP BY booking_id) s ON s.booking_id = sl.booking_id
GROUP BY d.car_model
ORDER BY [% Dangerous Trips] DESC