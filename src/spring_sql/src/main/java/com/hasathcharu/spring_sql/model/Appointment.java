package com.hasathcharu.spring_sql.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@Table(name = "appointment")
@Entity
@NoArgsConstructor
@Data
@AllArgsConstructor
public class Appointment {
    @Id
    private Integer id;
    private String reason;
    private AppointmentStatus status;
    @ManyToOne
    @JoinColumn(name = "doctorId")
    private Doctor doctor;
    @JoinColumn(name = "patient_id")
    @ManyToOne
    private Patient patient;
}
