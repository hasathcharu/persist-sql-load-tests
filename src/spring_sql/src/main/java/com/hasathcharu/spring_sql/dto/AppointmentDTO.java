package com.hasathcharu.spring_sql.dto;

import com.hasathcharu.spring_sql.model.AppointmentStatus;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class AppointmentDTO {
    private Integer id;
    private String reason;
    private AppointmentStatus status;
    private DoctorDTO doctor;
    private PatientDTO patient;
}
