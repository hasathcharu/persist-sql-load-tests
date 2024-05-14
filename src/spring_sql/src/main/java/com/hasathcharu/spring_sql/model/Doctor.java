package com.hasathcharu.spring_sql.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import jakarta.persistence.Table;

import java.util.List;


@Builder
@Entity
@NoArgsConstructor
@Data
@AllArgsConstructor
@Table(indexes = @Index(columnList = "specialty", name = "specialty_index"))
public class Doctor {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(columnDefinition = "CHAR(36)")
    private String id;
    private String name;
    @Column(columnDefinition = "VARCHAR(20)")
    private String specialty;
    @Column(name="phone_number")
    private String phoneNumber;
    @Column(columnDefinition = "DECIMAL(10,2)")
    private double salary;
}
