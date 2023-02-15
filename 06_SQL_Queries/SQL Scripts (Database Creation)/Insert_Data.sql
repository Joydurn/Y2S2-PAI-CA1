use Taxi_Trip
go

-- Loading CSV Files

-- Table driver
BULK INSERT dataLake.drivers
from 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\driver_data.csv'	    --Replace string to be the absolute path to the staffs data file
with (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

-- Table safety_labels
BULK INSERT dataLake.safety_labels
FROM 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\safety_labels.csv'	--Replace string to be the absolute path to the stores data file
WITH (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

-- Sensor Table
BULK INSERT dataLake.sensor
FROM 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\sensor_data\sensor_data_part-1.csv'	    --Replace string to be the absolute path to the staffs data file
WITH (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

BULK INSERT dataLake.sensor
FROM 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\sensor_data\sensor_data_part-2.csv'	    --Replace string to be the absolute path to the staffs data file
WITH (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

BULK INSERT dataLake.sensor
FROM 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\sensor_data\sensor_data_part-3.csv'	    --Replace string to be the absolute path to the staffs data file
WITH (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

BULK INSERT dataLake.sensor
FROM 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\sensor_data\sensor_data_part-4.csv'	    --Replace string to be the absolute path to the staffs data file
WITH (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

BULK INSERT dataLake.sensor
FROM 'C:\Users\loonw\Desktop\PAI\CA1\ST1508_dataset\sensor_data\sensor_data_part-5.csv'	    --Replace string to be the absolute path to the staffs data file
WITH (FIRSTROW = 2, fieldterminator=',', rowterminator='\n')

-- Alter Tables ( Change datatypes, add PK and FK )

-- Driver Table
ALTER TABLE dataLake.drivers ALTER COLUMN driver_id BIGINT NOT NULL;
ALTER TABLE dataLake.drivers ALTER COLUMN rating DECIMAL(2, 1);
ALTER TABLE dataLake.drivers ADD PRIMARY KEY (driver_id);

-- Safety Labels Table
ALTER TABLE dataLake.safety_labels ALTER COLUMN booking_id BIGINT NOT NULL;
ALTER TABLE dataLake.safety_labels ALTER COLUMN driver_id BIGINT NOT NULL;
ALTER TABLE dataLake.safety_labels ALTER COLUMN label INT;
ALTER TABLE dataLake.safety_labels ADD PRIMARY KEY (booking_id);
ALTER TABLE dataLake.safety_labels ADD FOREIGN KEY (driver_id) REFERENCES dataLake.drivers(driver_id) ON DELETE NO ACTION ON UPDATE NO ACTION

-- Sensor Table
ALTER TABLE datalake.sensor ADD sensorKey BIGINT IDENTITY(1, 1)
ALTER TABLE dataLake.sensor ALTER COLUMN booking_id BIGINT NOT NULL;
ALTER TABLE dataLake.sensor ALTER COLUMN accuracy FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN bearing FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN acceleration_x FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN acceleration_y FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN acceleration_z FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN gyro_x FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN gyro_y FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN gyro_z FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN second FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN gyro_z FLOAT;
ALTER TABLE dataLake.sensor ALTER COLUMN speed FLOAT;
ALTER TABLE dataLake.sensor ADD PRIMARY KEY (sensorKey);
ALTER TABLE dataLake.sensor ADD FOREIGN KEY (booking_id) REFERENCES dataLake.safety_labels(booking_id) ON DELETE NO ACTION ON UPDATE NO ACTION