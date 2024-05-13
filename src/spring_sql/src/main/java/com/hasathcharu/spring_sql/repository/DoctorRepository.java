package com.hasathcharu.spring_sql.repository;

import com.hasathcharu.spring_sql.model.Doctor;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepository extends JpaRepository<Doctor, String> {
}
