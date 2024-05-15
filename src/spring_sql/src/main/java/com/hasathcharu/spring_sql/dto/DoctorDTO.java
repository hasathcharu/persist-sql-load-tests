package com.hasathcharu.spring_sql.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class DoctorDTO {
    private String id;
    private String name;
    private String specialty;
    private String phoneNumber;
    private double salary;
}
