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

enum Gender {
    MALE,
    FEMALE
}

enum Status {
    STARTED,
    SCHEDULED,
    ENDED
}
type Doctor record {|
    readonly string id;
    string name;
    string specialty;
    @sql:Column{name:"phone_number"}
    string phoneNumber;
    decimal salary;
|};

type Patient record {|
    @sql:Column {name: "ID_P"}
    readonly int idP;
    string name;
    string phoneNumber;
    int age;
    @sql:Column {name: "ADDRESS"}
    string address;
    Gender gender;
|};

type Appointment record {|
    readonly int id;
    string doctorId;
    @sql:Column{name:"patient_id"}
    int patientId;
    string reason;
    Status status;
    Patient patient;
    Doctor doctor;
|};

service / on new http:Listener(9090) {
    
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
    
    isolated resource function get doctors/[string id]() returns Doctor|error{
        sql:ParameterizedQuery query = `SELECT * FROM Doctor WHERE id = ${id}`;
        Doctor result = check self.dbClient->queryRow(query);
        return result;
    }

    isolated resource function get patients() returns Patient[]|error {
        sql:ParameterizedQuery query = `SELECT * FROM patients`;
        stream<Patient, sql:Error?> result = self.dbClient->query(query);
        return from Patient patient in result select patient;
    }

    isolated resource function get appointments() returns Appointment[]|error {
        sql:ParameterizedQuery query = `
        SELECT 
            appointment.id, 
            appointment.reason, 
            appointment.status, 
            appointment.patient_id, 
            appointment.doctorId, 
            Patient.ID_P as "Patient.ID_P", 
            Patient.name as "Patient.name", 
            Patient.phoneNumber as "Patient.phoneNumber", 
            Patient.age as "Patient.age", 
            Patient.ADDRESS as "Patient.ADDRESS",
            Patient.gender as "Patient.gender",
            Doctor.id as "Doctor.id",
            Doctor.name as "Doctor.name",
            Doctor.specialty as "Doctor.specialty",
            Doctor.phone_number as "Doctor.phone_number",
            Doctor.salary as "Doctor.salary"
        FROM appointment INNER JOIN patients Patient ON appointment.patient_id = Patient.ID_P 
        INNER JOIN Doctor ON appointment.doctorId = Doctor.id 
        WHERE appointment.status = "STARTED"`;
        stream<Appointment, sql:Error?> result = self.dbClient->query(query);
        return from Appointment appointment in result select appointment;
    }

}
