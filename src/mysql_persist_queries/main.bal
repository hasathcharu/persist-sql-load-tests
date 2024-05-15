import ballerina/http;
import ballerina/uuid;
import ballerina/sql;
import ballerinax/mysql;
import ballerinax/mysql.driver as _;

configurable string host = ?;
configurable string username = ?;
configurable string password = ?;
configurable string database = ?;
configurable int port = ?;

service / on new http:Listener(9093) {
    
    private final mysql:Client dbClient;

    function init() returns error? {
        self.dbClient = check new (host, username, password, database, port);
    }

    isolated resource function get insert\-doctors() returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly|error {
        var doctor = {
            id: uuid:createRandomUuid(),
            name: "John Doe",
            phoneNumber: "0711232345",
            salary: 500.00,
            specialty: "Physician"
        };
        sql:ParameterizedQuery query = `INSERT INTO Doctor (id, name, phone_number, salary, specialty) VALUES (${doctor.id}, ${doctor.name}, ${doctor.phoneNumber}, ${doctor.salary}, ${doctor.specialty})`;
        _ = check self.dbClient->execute(query);
        return http:CREATED;
    }

    isolated resource function get insert\-patients() returns http:InternalServerError & readonly|http:Created|error {
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

    isolated resource function get insert\-appointments(int appointmentId) returns http:InternalServerError & readonly|http:Created & readonly|http:Conflict & readonly|error {
        string[] statuses = ["STARTED", "SCHEDULED", "ENDED"];
        var appointment = {
            id: appointmentId,
            doctorId: "id1",
            patientId: 1,
            reason: "Checkup",
            status: statuses[appointmentId % 3]
        };
        sql:ParameterizedQuery query = `INSERT INTO appointment (id, reason, status, patient_id, doctorId) VALUES (${appointment.id}, ${appointment.reason}, ${appointment.status}, ${appointment.patientId}, ${appointment.doctorId})`;
        _ = check self.dbClient->execute(query);
        return http:CREATED;
    }
    
    isolated resource function get doctors/[string id]() returns record {|anydata...;|}|error{
        sql:ParameterizedQuery query = `SELECT Doctor.id AS id,Doctor.name AS name,Doctor.specialty AS specialty,Doctor.phone_number AS phoneNumber,Doctor.salary AS salary FROM Doctor AS Doctor WHERE  Doctor.id = ${id}`;
        record {|anydata...;|} result = check self.dbClient->queryRow(query);
        return result;
        
    }

    isolated resource function get patients() returns record {|anydata...;|}[]|error {
        sql:ParameterizedQuery query = `SELECT Patient.ID_P AS idP,Patient.name AS name,Patient.age AS age,Patient.ADDRESS AS address,Patient.phoneNumber AS phoneNumber,Patient.gender AS gender FROM patients AS Patient`;
        stream<record {|anydata...;|}, sql:Error?> result = self.dbClient->query(query);
        return from var patient in result select patient;
    }

    isolated resource function get appointments() returns record {|anydata...;|}[]|error {
        sql:ParameterizedQuery query = `
        SELECT 
            patient.ID_P AS patient.idP,
            patient.name AS patient.name,
            patient.age AS patient.age,
            patient.ADDRESS AS patient.address,
            patient.phoneNumber AS patient.phoneNumber,
            patient.gender AS patient.gender,
            doctor.id AS doctor.id,
            doctor.name AS doctor.name,
            doctor.specialty AS doctor.specialty,
            doctor.phone_number AS doctor.phoneNumber,
            doctor.salary AS doctor.salary,
            Appointment.id AS id,
            Appointment.reason AS reason,
            Appointment.status AS status,
            Appointment.patient_id AS patientId,
            Appointment.doctorId AS doctorId 
        FROM 
            appointment AS Appointment LEFT JOIN patients patient 
            ON patient.ID_P = Appointment.patient_id 
            LEFT JOIN Doctor doctor ON  doctor.id = Appointment.doctorId
        WHERE status = "STARTED"
        `;

        stream<record {|anydata...;|}, sql:Error?> result = self.dbClient->query(query);
        return from var appointment in result select appointment;
    }

}
