package com.hasathcharu.spring_sql.repository;

import com.hasathcharu.spring_sql.model.Patient;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PatientRepository extends JpaRepository<Patient, Integer> {
}
