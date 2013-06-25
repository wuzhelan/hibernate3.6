package com.h.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

@Entity
@Table(name="cats")
public class Cat implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue
	private Long id; // identifier
	
	@Temporal(TemporalType.DATE)
	@Column
	@NotNull
	private Date birthdate;


	private void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}

	public void setBirthdate(Date date) {
		birthdate = date;
	}

	public Date getBirthdate() {
		return birthdate;
	}
	
	
}