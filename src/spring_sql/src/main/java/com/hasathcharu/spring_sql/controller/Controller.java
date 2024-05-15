package com.hasathcharu.spring_sql.controller;

import com.hasathcharu.spring_sql.dto.AppointmentDTO;
import com.hasathcharu.spring_sql.dto.DoctorDTO;
import com.hasathcharu.spring_sql.dto.PatientDTO;
import com.hasathcharu.spring_sql.model.Appointment;
import com.hasathcharu.spring_sql.model.Doctor;
import com.hasathcharu.spring_sql.model.Patient;
import com.hasathcharu.spring_sql.service.AppointmentService;
import com.hasathcharu.spring_sql.service.DoctorService;
import com.hasathcharu.spring_sql.service.PatientService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/")
@RequiredArgsConstructor
public class Controller {

    private final AppointmentService appointmentService;
    private final DoctorService doctorService;
    private final PatientService patientService;

    @GetMapping("/insert-doctors")
    public void insertDoctors() {
        doctorService.createDoctor();
    }

    @GetMapping("/insert-patients")
    public void insertPatients() {
        patientService.createPatient();
    }

    @GetMapping("/insert-appointments")
    public void insertAppointments(@RequestParam int appointmentId) {
        appointmentService.createAppointment(appointmentId);
    }

    @GetMapping("/doctors/{id}")
    public DoctorDTO getDoctorById(@PathVariable String id) {
        return doctorService.getDoctorById(id);
    }

    @GetMapping("/patients")
    public List<PatientDTO> getAllPatients() {
        return patientService.getAllPatients();
    }

    @GetMapping("/appointments")
    public List<AppointmentDTO> getStartedAppointments() {
        return appointmentService.getStartedAppointments();
    }

}
