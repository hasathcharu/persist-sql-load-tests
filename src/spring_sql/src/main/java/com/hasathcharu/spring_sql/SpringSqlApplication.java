package com.hasathcharu.spring_sql;

import com.hasathcharu.spring_sql.repository.DoctorRepository;
import com.hasathcharu.spring_sql.repository.PatientRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class SpringSqlApplication {

	public static void main(String[] args) {
		SpringApplication.run(SpringSqlApplication.class, args);
	}

}
