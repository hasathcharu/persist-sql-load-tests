package com.hasathcharu.spring_sql.service;

import com.hasathcharu.spring_sql.dto.PatientDTO;
import com.hasathcharu.spring_sql.model.Gender;
import com.hasathcharu.spring_sql.model.Patient;
import com.hasathcharu.spring_sql.repository.PatientRepository;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

import static java.util.stream.Collectors.toList;

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

    public List<PatientDTO> getAllPatients() {
        return patientRepository.findAll().stream().map(patient ->
                PatientDTO.builder()
                    .idP(patient.getIdP())
                    .name(patient.getName())
                    .age(patient.getAge())
                    .phoneNumber(patient.getPhoneNumber())
                    .address(patient.getAddress())
                    .build()).toList();
    }
}
