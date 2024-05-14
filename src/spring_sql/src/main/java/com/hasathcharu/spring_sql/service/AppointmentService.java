package com.hasathcharu.spring_sql.service;

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

    public List<Appointment> getStartedAppointments() {
        return appointmentRepository.findAllByStatus(AppointmentStatus.STARTED);
    }

}
