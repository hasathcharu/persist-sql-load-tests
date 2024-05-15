import ballerina/http;
import ballerina/persist;
import load_tests.db;
import ballerina/io;
import ballerina/uuid;

const db:PatientInsert patient = {
    name: "Jane Doe",
    phoneNumber: "0711232345",
    age: 25,
    address: "Colombo",
    gender: db:MALE
};


service / on new http:Listener(9090) {
    
    private final db:Client dbClient;

    function init() returns error? {
        self.dbClient = check new ();
    }

    isolated resource function get insert\-doctors() returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly {
        db:DoctorInsert doctor = {
            id: uuid:createRandomUuid(),
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

    isolated resource function get insert\-patients() returns http:InternalServerError & readonly|http:Created {
        int[]|persist:Error result = self.dbClient->/patients.post([patient]);
        if result is persist:Error {
            io:println(result);
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:CREATED;
    }

    isolated resource function get insert\-appointments(int appointmentId) returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly {
        db:AppointmentStatus[] statuses = [db:STARTED, db:SCHEDULED, db:ENDED];
        db:AppointmentInsert appointment = {
            id: appointmentId,
            doctorId: "id1",
            patientId: 1,
            reason: "Checkup",
            status: statuses[appointmentId % 3]
        };
        int[]|persist:Error result = self.dbClient->/appointments.post([appointment]);
        if result is persist:Error {
            io:println(result);
            return http:INTERNAL_SERVER_ERROR;
        }
        return http:CREATED;
    }


    isolated resource function get doctors/[string id]() returns db:Doctor|persist:Error? {
        db:Doctor doctor = check self.dbClient->/doctors/[id];
        return doctor;
    }

    isolated resource function get patients() returns db:Patient[]|error {
        stream<db:Patient, persist:Error?> patients = self.dbClient->/patients.get();
        return from db:Patient patient in patients
            select patient;
    }

    isolated resource function get appointments() returns db:AppointmentWithRelations[]|error {
        return check from db:AppointmentWithRelations appointment in self.dbClient->/appointments.get(targetType = db:AppointmentWithRelations, whereClause = `status = "STARTED"`)
        select appointment;
    }

}
