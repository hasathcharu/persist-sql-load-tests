package com.hasathcharu.spring_sql.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Builder
@Table(name = "patients")
@Entity
@NoArgsConstructor
@Data
@AllArgsConstructor
public class Patient {
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ID_P")
    @Id
    private Integer idP;
    private String name;
    private int age;
    @Column(name = "ADDRESS")
    private String address;
    @Column(columnDefinition="CHAR(10)")
    private String phoneNumber;
    private Gender gender;
}
