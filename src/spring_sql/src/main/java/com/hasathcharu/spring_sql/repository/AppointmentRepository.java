package com.hasathcharu.spring_sql.repository;

import com.hasathcharu.spring_sql.model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {
}
