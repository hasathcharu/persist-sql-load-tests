package com.hasathcharu.spring_sql.dto;

import com.hasathcharu.spring_sql.model.Gender;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Builder
@NoArgsConstructor
@AllArgsConstructor
@Data
public class PatientDTO {
    private Integer idP;
    private String name;
    private int age;
    private String address;
    private String phoneNumber;
    private Gender gender;
}
