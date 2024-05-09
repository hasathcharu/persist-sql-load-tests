import ballerina/persist as _;

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
    Patient patient;
    Doctor doctor;
|};

public type Patient record {|
    readonly int idP;
    string name;
    int age;
    string address;
    string phoneNumber;
    PatientGender gender;
    Appointment[] appointments;
|};

public type Doctor record {|
    readonly string id;
    string name;
    string specialty;
    string phoneNumber;
    decimal salary;
    Appointment[] appointments;
|};

