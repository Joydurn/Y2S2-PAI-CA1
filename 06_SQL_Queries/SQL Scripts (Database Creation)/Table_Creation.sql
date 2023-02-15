create database Taxi_Trip
go
use Taxi_Trip
go
create schema dataLake -- Raw data
go
create schema dataCleansed -- Cleaned data
go

-- Drivers Table 
CREATE TABLE dataLake.drivers(
	driver_id  VARCHAR(10) NOT NULL,
	name VARCHAR(255) NOT NULL,
	date_of_birth VARCHAR(255) NOT NULL,
	gender VARCHAR(255) NOT NULL,
	car_model VARCHAR(255) NOT NULL,
	car_make_year VARCHAR(255) NOT NULL,
	rating VARCHAR(255) NOT NULL
)

-- Safety Labels
CREATE TABLE dataLake.safety_labels(
	booking_id VARCHAR(255) NOT NULL,
	driver_id VARCHAR(10) NOT NULL,
	label VARCHAR(10) NOT NULL,
)

-- Sensor Table
CREATE TABLE dataLake.sensor(
	booking_id VARCHAR(255) NOT NULL,
	accuracy VARCHAR(255),
	bearing VARCHAR(255),
	acceleration_x VARCHAR(255),
	acceleration_y VARCHAR(255),
	acceleration_z VARCHAR(255),
	gyro_x VARCHAR(255),
	gyro_y VARCHAR(255),
	gyro_z VARCHAR(255),
	second VARCHAR(255) NOT NULL,
	speed VARCHAR(255),
)