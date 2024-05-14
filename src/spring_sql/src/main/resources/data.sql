DROP DATABASE IF EXISTS spring_hospital;
CREATE DATABASE spring_hospital;
USE spring_hospital;

CREATE TABLE `Doctor` (
    `salary` decimal(10,2) DEFAULT NULL,
    `id` char(36) NOT NULL,
    `name` varchar(255) DEFAULT NULL,
    `phone_number` varchar(255) DEFAULT NULL,
    `specialty` varchar(20) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `specialty_index` (`specialty`)
);

CREATE TABLE `patients` (
    `ID_P` int NOT NULL AUTO_INCREMENT,
    `age` int NOT NULL,
    `gender` tinyint DEFAULT NULL,
    `ADDRESS` varchar(255) DEFAULT NULL,
    `name` varchar(255) DEFAULT NULL,
    `phoneNumber` char(10) DEFAULT NULL,
    PRIMARY KEY (`ID_P`)
);

CREATE TABLE `appointment` (
    `id` int NOT NULL,
    `patient_id` int DEFAULT NULL,
    `status` tinyint DEFAULT NULL,
    `doctorId` char(36) DEFAULT NULL,
    `reason` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`patient_id`) REFERENCES `patients` (`ID_P`),
    FOREIGN KEY (`doctorId`) REFERENCES `Doctor` (`id`)
);

INSERT INTO Doctor (id, name, specialty, phone_number, salary) VALUES ('id1', 'Dr. John Doe', 'Cardiologist', '0712345678', 100000.00);
INSERT INTO patients (name, age, ADDRESS, phoneNumber, gender) VALUES ('Alice', 25, 'Colombo', '0701231234', 0);
