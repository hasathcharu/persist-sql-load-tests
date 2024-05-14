package com.hasathcharu.spring_sql.service;

import com.hasathcharu.spring_sql.model.Gender;
import com.hasathcharu.spring_sql.model.Patient;
import com.hasathcharu.spring_sql.repository.PatientRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
@Transactional
public class PatientService {
    private final PatientRepository  patientRepository;

    public void createPatient() {
        Patient.PatientBuilder patientBuilder = Patient.builder();
        Patient patient = patientBuilder
                .name("Jane Doe")
                .age(25)
                .phoneNumber("0711232345")
                .address("Colombo")
                .gender(Gender.MALE)
                .build();
        patientRepository.save(patient);
    }

    public List<Patient> getAllPatients() {
        return patientRepository.findAll();
    }
}
