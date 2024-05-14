package com.hasathcharu.spring_sql.service;

import com.hasathcharu.spring_sql.model.Doctor;
import com.hasathcharu.spring_sql.repository.DoctorRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
@Transactional
public class DoctorService {
    private final DoctorRepository doctorRepository;

    public void createDoctor() {
        Doctor.DoctorBuilder doctorBuilder = Doctor.builder();
        Doctor doctor = doctorBuilder
                .name("Dr. John Doe")
                .phoneNumber("0711232345")
                .salary(500.00)
                .specialty("Physician")
                .build();
        doctorRepository.save(doctor);
    }

    public Doctor getDoctorById(String id) {
        return doctorRepository.findById(id).orElse(null);
    }

}
