// Copyright (c) 2024 WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/http;
import ballerina/uuid;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

int appointmentId = 0;


service / on new http:Listener(9090) {
    
    private final mysql:Client dbClient;

    function init() returns error? {
        self.dbClient = check new ("localhost", "root", "Test123#", "hospital", 3300);
    }

    isolated resource function get doctors() returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly|error {
        var doctor = {
            id: uuid:createType1AsString(),
            name: "John Doe",
            phoneNumber: "0711232345",
            salary: 500.00,
            specialty: "Physician"
        };
        sql:ParameterizedQuery query = `INSERT INTO Doctor (id, name, phone_number, salary, specialty) VALUES (${doctor.id}, ${doctor.name}, ${doctor.phoneNumber}, ${doctor.salary}, ${doctor.specialty})`;
        _ = check self.dbClient->execute(query);
        return http:CREATED;
    }

    isolated resource function get patients() returns http:InternalServerError & readonly|http:Created|error {
        var patient = {
            name: "Jane Doe",
            phoneNumber: "0711232345",
            age: 25,
            address: "Colombo",
            gender: "MALE"
        };
        sql:ParameterizedQuery query = `INSERT INTO patients (name, age, ADDRESS, phoneNumber, gender) VALUES (${patient.name}, ${patient.age}, ${patient.address}, ${patient.phoneNumber}, ${patient.gender})`;
        _ = check self.dbClient->execute(query);
        return http:CREATED;
    }

    resource function get appointments() returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly|error {
        appointmentId = appointmentId + 1;
        var appointment = {
            id: appointmentId,
            doctorId: "id1",
            patientId: 1,
            reason: "Checkup",
            status: "STARTED"
        };
        sql:ParameterizedQuery query = `INSERT INTO appointment (id, reason, status, patient_id, doctorId) VALUES (${appointment.id}, ${appointment.reason}, ${appointment.status}, ${appointment.patientId}, ${appointment.doctorId})`;
        _ = check self.dbClient->execute(query);
        return http:CREATED;
    }
}
