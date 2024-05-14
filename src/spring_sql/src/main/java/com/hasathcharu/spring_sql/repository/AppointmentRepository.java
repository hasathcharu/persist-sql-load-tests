package com.hasathcharu.spring_sql.repository;

import com.hasathcharu.spring_sql.model.Appointment;
import com.hasathcharu.spring_sql.model.AppointmentStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AppointmentRepository extends JpaRepository<Appointment, Integer> {
    List<Appointment> findAllByStatus(AppointmentStatus status);
}
