-- AUTO-GENERATED FILE.

-- This file is an auto-generated file by Ballerina persistence layer for model.
-- Please verify the generated scripts and execute them against the target DB server.

DROP TABLE IF EXISTS `appointment`;
DROP TABLE IF EXISTS `patients`;
DROP TABLE IF EXISTS `Doctor`;

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


CREATE INDEX `patient_id` ON `appointment` (`patient_id`);
CREATE INDEX `doctorId` ON `appointment` (`doctorId`);
CREATE INDEX `specialty_index` ON `Doctor` (`specialty`);
