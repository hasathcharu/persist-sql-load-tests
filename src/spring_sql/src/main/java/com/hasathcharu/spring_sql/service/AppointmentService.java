package com.hasathcharu.spring_sql.service;

import com.hasathcharu.spring_sql.dto.AppointmentDTO;
import com.hasathcharu.spring_sql.dto.DoctorDTO;
import com.hasathcharu.spring_sql.dto.PatientDTO;
import com.hasathcharu.spring_sql.model.Appointment;
import com.hasathcharu.spring_sql.model.AppointmentStatus;
import com.hasathcharu.spring_sql.repository.AppointmentRepository;
import com.hasathcharu.spring_sql.repository.DoctorRepository;
import com.hasathcharu.spring_sql.repository.PatientRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional
public class AppointmentService {

    private final AppointmentRepository appointmentRepository;
    private final PatientRepository patientRepository;
    private final DoctorRepository doctorRepository;

    public void createAppointment(int appointmentId) {
        AppointmentStatus[] appointmentStatuses = {AppointmentStatus.STARTED, AppointmentStatus.ENDED,
                AppointmentStatus.SCHEDULED};
        Appointment.AppointmentBuilder appointmentBuilder = Appointment.builder();
        Appointment appointment = appointmentBuilder
                .id(appointmentId)
                .status(appointmentStatuses[appointmentId%3])
                .doctor(doctorRepository.findById("id1").orElse(null))
                .patient(patientRepository.findById(1).orElse(null))
                .reason("Checkup")
                .build();
        appointmentRepository.save(appointment);
    }

    public List<AppointmentDTO> getStartedAppointments() {
        return appointmentRepository.findAllByStatus(AppointmentStatus.STARTED).stream().map(appointment ->
                AppointmentDTO.builder()
                    .id(appointment.getId())
                    .reason(appointment.getReason())
                    .status(appointment.getStatus())
                    .doctor(DoctorDTO.builder()
                        .id(appointment.getDoctor().getId())
                        .name(appointment.getDoctor().getName())
                        .phoneNumber(appointment.getDoctor().getPhoneNumber())
                        .salary(appointment.getDoctor().getSalary())
                        .specialty(appointment.getDoctor().getSpecialty())
                        .build())
                    .patient(PatientDTO.builder()
                        .idP(appointment.getPatient().getIdP())
                        .name(appointment.getPatient().getName())
                        .age(appointment.getPatient().getAge())
                        .phoneNumber(appointment.getPatient().getPhoneNumber())
                        .address(appointment.getPatient().getAddress())
                        .gender(appointment.getPatient().getGender())
                        .build())
                    .build()).toList();
    }

}
