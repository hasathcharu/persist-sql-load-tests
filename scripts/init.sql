DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

CREATE TABLE `Doctor` (
	`id` CHAR(36) NOT NULL,
	`name` VARCHAR(191) NOT NULL,
	`specialty` VARCHAR(20) NOT NULL,
	`phone_number` VARCHAR(191) NOT NULL,
	`salary` DECIMAL(10,2),
	PRIMARY KEY(`id`)
);

CREATE TABLE `patients` (
	`ID_P` INT AUTO_INCREMENT,
	`name` VARCHAR(191) NOT NULL,
	`age` INT NOT NULL,
	`ADDRESS` VARCHAR(191) NOT NULL,
	`phoneNumber` CHAR(10) NOT NULL,
	`gender` ENUM('MALE', 'FEMALE') NOT NULL,
	PRIMARY KEY(`ID_P`)
);

CREATE TABLE `appointment` (
	`id` INT NOT NULL,
	`reason` VARCHAR(191) NOT NULL,
	`status` ENUM('SCHEDULED', 'STARTED', 'ENDED') NOT NULL,
	`patient_id` INT NOT NULL,
	FOREIGN KEY(`patient_id`) REFERENCES `patients`(`ID_P`),
	`doctorId` CHAR(36) NOT NULL,
	FOREIGN KEY(`doctorId`) REFERENCES `Doctor`(`id`),
	PRIMARY KEY(`id`)
);

CREATE INDEX `specialty_index` ON `Doctor` (`specialty`);

INSERT INTO Doctor (id, name, specialty, phone_number, salary) VALUES ('id1', 'Dr. John Doe', 'Cardiologist', '0712345678', 100000.00);
INSERT INTO patients (name, age, ADDRESS, phoneNumber, gender) VALUES ('Alice', 25, 'Colombo', '0701231234', 'MALE');
