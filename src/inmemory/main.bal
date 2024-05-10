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
import ballerina/persist;
import inmemory.db;
import ballerina/io;
import ballerina/uuid;

int appointmentId = 0;
int patientId = 0;


service / on new http:Listener(9090) {
    
    private final db:Client dbClient;

    function init() returns error? {
        self.dbClient = check new ();
    }

    isolated resource function get doctors() returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly {
        db:DoctorInsert doctor = {
            id: uuid:createType1AsString(),
            name: "John Doe",
            phoneNumber: "0711232345",
            salary: 500.00,
            specialty: "Physician"
        };
        string[]|persist:Error result = self.dbClient->/doctors.post([doctor]);
        if result is persist:Error {
            io:println(result);
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:CREATED;
    }

    resource function get patients() returns http:InternalServerError & readonly|http:Created {
        patientId = patientId + 1;
        db:PatientInsert patient = {
            idP: patientId,
            name: "Jane Doe",
            phoneNumber: "0711232345",
            age: 25,
            address: "Colombo",
            gender: db:MALE
        };
        int[]|persist:Error result = self.dbClient->/patients.post([patient]);
        if result is persist:Error {
            io:println(result);
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:CREATED;
    }

    resource function get appointments() returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly {
        appointmentId = appointmentId + 1;
        db:AppointmentInsert appointment = {
            id: appointmentId,
            doctorId: "01ef0dcb-b819-1dee-8e6a-e7e38da58b44",
            patientIdP: 1,
            reason: "Checkup",
            status: db:STARTED
        };
        int[]|persist:Error result = self.dbClient->/appointments.post([appointment]);
        if result is persist:Error {
            io:println(result);
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:CREATED;
    }

    resource function get allData() returns http:Ok & readonly|error {
        stream<db:Doctor, persist:Error?> doctors = self.dbClient->/doctors.get();
        stream<db:Patient, persist:Error?> patients = self.dbClient->/patients.get();
        stream<db:Appointment, persist:Error?> appointments = self.dbClient->/appointments.get();
        string[] doctorArray = check from var doctor in doctors select doctor.toString();
        string[] patientArray = check from var patient in patients select patient.toString();
        string[] appointmentArray = check from var appointment in appointments select appointment.toString();
        _ = check io:fileWriteCsv("doctorData.txt", [doctorArray]);
        _ = check io:fileWriteCsv("patientData.txt", [patientArray]);
        _ = check io:fileWriteCsv("appointmentData.txt", [appointmentArray]);
        return http:OK;
    }
}
