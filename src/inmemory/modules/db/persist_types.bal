// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public enum AppointmentStatus {
    SCHEDULED = "SCHEDULED",
    STARTED = "STARTED",
    ENDED = "ENDED"
}

public enum PatientGender {
    MALE = "MALE",
    FEMALE = "FEMALE"
}

public type Appointment record {|
    readonly int id;
    string reason;
    AppointmentStatus status;
    int patientIdP;
    string doctorId;
|};

public type AppointmentOptionalized record {|
    int id?;
    string reason?;
    AppointmentStatus status?;
    int patientIdP?;
    string doctorId?;
|};

public type AppointmentWithRelations record {|
    *AppointmentOptionalized;
    PatientOptionalized patient?;
    DoctorOptionalized doctor?;
|};

public type AppointmentTargetType typedesc<AppointmentWithRelations>;

public type AppointmentInsert Appointment;

public type AppointmentUpdate record {|
    string reason?;
    AppointmentStatus status?;
    int patientIdP?;
    string doctorId?;
|};

public type Patient record {|
    readonly int idP;
    string name;
    int age;
    string address;
    string phoneNumber;
    PatientGender gender;

|};

public type PatientOptionalized record {|
    int idP?;
    string name?;
    int age?;
    string address?;
    string phoneNumber?;
    PatientGender gender?;
|};

public type PatientWithRelations record {|
    *PatientOptionalized;
    AppointmentOptionalized[] appointments?;
|};

public type PatientTargetType typedesc<PatientWithRelations>;

public type PatientInsert Patient;

public type PatientUpdate record {|
    string name?;
    int age?;
    string address?;
    string phoneNumber?;
    PatientGender gender?;
|};

public type Doctor record {|
    readonly string id;
    string name;
    string specialty;
    string phoneNumber;
    decimal salary;

|};

public type DoctorOptionalized record {|
    string id?;
    string name?;
    string specialty?;
    string phoneNumber?;
    decimal salary?;
|};

public type DoctorWithRelations record {|
    *DoctorOptionalized;
    AppointmentOptionalized[] appointments?;
|};

public type DoctorTargetType typedesc<DoctorWithRelations>;

public type DoctorInsert Doctor;

public type DoctorUpdate record {|
    string name?;
    string specialty?;
    string phoneNumber?;
    decimal salary?;
|};

