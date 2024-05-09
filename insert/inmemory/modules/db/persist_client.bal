// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.redis as predis;
import ballerinax/redis;

const APPOINTMENT = "appointments";
const PATIENT = "patients";
const DOCTOR = "doctors";

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final redis:Client dbClient;

    private final map<predis:RedisClient> persistClients;

    private final record {|predis:RedisMetadata...;|} & readonly metadata = {
        [APPOINTMENT]: {
            entityName: "Appointment",
            collectionName: "Appointment",
            fieldMetadata: {
                id: {fieldName: "id", fieldDataType: predis:INT},
                reason: {fieldName: "reason", fieldDataType: predis:STRING},
                status: {fieldName: "status", fieldDataType: predis:STRING},
                patientIdP: {fieldName: "patientIdP", fieldDataType: predis:INT},
                doctorId: {fieldName: "doctorId", fieldDataType: predis:STRING},
                "patient.idP": {relation: {entityName: "patient", refField: "idP", refFieldDataType: predis:INT}},
                "patient.name": {relation: {entityName: "patient", refField: "name", refFieldDataType: predis:STRING}},
                "patient.age": {relation: {entityName: "patient", refField: "age", refFieldDataType: predis:INT}},
                "patient.address": {relation: {entityName: "patient", refField: "address", refFieldDataType: predis:STRING}},
                "patient.phoneNumber": {relation: {entityName: "patient", refField: "phoneNumber", refFieldDataType: predis:STRING}},
                "patient.gender": {relation: {entityName: "patient", refField: "gender", refFieldDataType: predis:STRING}},
                "doctor.id": {relation: {entityName: "doctor", refField: "id", refFieldDataType: predis:STRING}},
                "doctor.name": {relation: {entityName: "doctor", refField: "name", refFieldDataType: predis:STRING}},
                "doctor.specialty": {relation: {entityName: "doctor", refField: "specialty", refFieldDataType: predis:STRING}},
                "doctor.phoneNumber": {relation: {entityName: "doctor", refField: "phoneNumber", refFieldDataType: predis:STRING}},
                "doctor.salary": {relation: {entityName: "doctor", refField: "salary", refFieldDataType: predis:DECIMAL}}
            },
            keyFields: ["id"],
            refMetadata: {
                patient: {entity: Patient, fieldName: "patient", refCollection: "Patient", refMetaDataKey: "appointments", refFields: ["idP"], joinFields: ["patientIdP"], 'type: predis:ONE_TO_MANY},
                doctor: {entity: Doctor, fieldName: "doctor", refCollection: "Doctor", refMetaDataKey: "appointments", refFields: ["id"], joinFields: ["doctorId"], 'type: predis:ONE_TO_MANY}
            }
        },
        [PATIENT]: {
            entityName: "Patient",
            collectionName: "Patient",
            fieldMetadata: {
                idP: {fieldName: "idP", fieldDataType: predis:INT},
                name: {fieldName: "name", fieldDataType: predis:STRING},
                age: {fieldName: "age", fieldDataType: predis:INT},
                address: {fieldName: "address", fieldDataType: predis:STRING},
                phoneNumber: {fieldName: "phoneNumber", fieldDataType: predis:STRING},
                gender: {fieldName: "gender", fieldDataType: predis:STRING},
                "appointments[].id": {relation: {entityName: "appointments", refField: "id", refFieldDataType: predis:INT}},
                "appointments[].reason": {relation: {entityName: "appointments", refField: "reason", refFieldDataType: predis:STRING}},
                "appointments[].status": {relation: {entityName: "appointments", refField: "status", refFieldDataType: predis:STRING}},
                "appointments[].patientIdP": {relation: {entityName: "appointments", refField: "patientIdP", refFieldDataType: predis:INT}},
                "appointments[].doctorId": {relation: {entityName: "appointments", refField: "doctorId", refFieldDataType: predis:STRING}}
            },
            keyFields: ["idP"],
            refMetadata: {appointments: {entity: Appointment, fieldName: "appointments", refCollection: "Appointment", refFields: ["patientIdP"], joinFields: ["idP"], 'type: predis:MANY_TO_ONE}}
        },
        [DOCTOR]: {
            entityName: "Doctor",
            collectionName: "Doctor",
            fieldMetadata: {
                id: {fieldName: "id", fieldDataType: predis:STRING},
                name: {fieldName: "name", fieldDataType: predis:STRING},
                specialty: {fieldName: "specialty", fieldDataType: predis:STRING},
                phoneNumber: {fieldName: "phoneNumber", fieldDataType: predis:STRING},
                salary: {fieldName: "salary", fieldDataType: predis:DECIMAL},
                "appointments[].id": {relation: {entityName: "appointments", refField: "id", refFieldDataType: predis:INT}},
                "appointments[].reason": {relation: {entityName: "appointments", refField: "reason", refFieldDataType: predis:STRING}},
                "appointments[].status": {relation: {entityName: "appointments", refField: "status", refFieldDataType: predis:STRING}},
                "appointments[].patientIdP": {relation: {entityName: "appointments", refField: "patientIdP", refFieldDataType: predis:INT}},
                "appointments[].doctorId": {relation: {entityName: "appointments", refField: "doctorId", refFieldDataType: predis:STRING}}
            },
            keyFields: ["id"],
            refMetadata: {appointments: {entity: Appointment, fieldName: "appointments", refCollection: "Appointment", refFields: ["doctorId"], joinFields: ["id"], 'type: predis:MANY_TO_ONE}}
        }
    };

    public isolated function init() returns persist:Error? {
        redis:Client|error dbClient = new (connectionConfig);
        if dbClient is error {
            return <persist:Error>error(dbClient.message());
        }
        self.dbClient = dbClient;
        self.persistClients = {
            [APPOINTMENT]: check new (dbClient, self.metadata.get(APPOINTMENT), cacheConfig.maxAge),
            [PATIENT]: check new (dbClient, self.metadata.get(PATIENT), cacheConfig.maxAge),
            [DOCTOR]: check new (dbClient, self.metadata.get(DOCTOR), cacheConfig.maxAge)
        };
    }

    isolated resource function get appointments(AppointmentTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.redis.datastore.RedisProcessor",
        name: "query"
    } external;

    isolated resource function get appointments/[int id](AppointmentTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.redis.datastore.RedisProcessor",
        name: "queryOne"
    } external;

    isolated resource function post appointments(AppointmentInsert[] data) returns int[]|persist:Error {
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(APPOINTMENT);
        }
        _ = check redisClient.runBatchInsertQuery(data);
        return from AppointmentInsert inserted in data
            select inserted.id;
    }

    isolated resource function put appointments/[int id](AppointmentUpdate value) returns Appointment|persist:Error {
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(APPOINTMENT);
        }
        _ = check redisClient.runUpdateQuery(id, value);
        return self->/appointments/[id].get();
    }

    isolated resource function delete appointments/[int id]() returns Appointment|persist:Error {
        Appointment result = check self->/appointments/[id].get();
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(APPOINTMENT);
        }
        _ = check redisClient.runDeleteQuery(id);
        return result;
    }

    isolated resource function get patients(PatientTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.redis.datastore.RedisProcessor",
        name: "query"
    } external;

    isolated resource function get patients/[int idP](PatientTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.redis.datastore.RedisProcessor",
        name: "queryOne"
    } external;

    isolated resource function post patients(PatientInsert[] data) returns int[]|persist:Error {
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(PATIENT);
        }
        _ = check redisClient.runBatchInsertQuery(data);
        return from PatientInsert inserted in data
            select inserted.idP;
    }

    isolated resource function put patients/[int idP](PatientUpdate value) returns Patient|persist:Error {
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(PATIENT);
        }
        _ = check redisClient.runUpdateQuery(idP, value);
        return self->/patients/[idP].get();
    }

    isolated resource function delete patients/[int idP]() returns Patient|persist:Error {
        Patient result = check self->/patients/[idP].get();
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(PATIENT);
        }
        _ = check redisClient.runDeleteQuery(idP);
        return result;
    }

    isolated resource function get doctors(DoctorTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.redis.datastore.RedisProcessor",
        name: "query"
    } external;

    isolated resource function get doctors/[string id](DoctorTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.redis.datastore.RedisProcessor",
        name: "queryOne"
    } external;

    isolated resource function post doctors(DoctorInsert[] data) returns string[]|persist:Error {
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(DOCTOR);
        }
        _ = check redisClient.runBatchInsertQuery(data);
        return from DoctorInsert inserted in data
            select inserted.id;
    }

    isolated resource function put doctors/[string id](DoctorUpdate value) returns Doctor|persist:Error {
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(DOCTOR);
        }
        _ = check redisClient.runUpdateQuery(id, value);
        return self->/doctors/[id].get();
    }

    isolated resource function delete doctors/[string id]() returns Doctor|persist:Error {
        Doctor result = check self->/doctors/[id].get();
        predis:RedisClient redisClient;
        lock {
            redisClient = self.persistClients.get(DOCTOR);
        }
        _ = check redisClient.runDeleteQuery(id);
        return result;
    }

    public isolated function close() returns persist:Error? {
        error? result = self.dbClient.close();
        if result is error {
            return <persist:Error>error(result.message());
        }
        return result;
    }
}

