package entities;

import java.io.Serializable;
import java.util.Date;

/**
 * Task bean for modelling database tables
 * @author Josh
 * 
 * updated by skyet 02/22
 * This class represents a model of Task data
 * It acts as the domain-specific class that the application
 * will use to represent the "tasks" table of the database
 */
public class Task implements Serializable{
	private static final long serialVersionUID = -218272690039621900L;

	private int id;
	private String name;
	private String description;
	private Date startDate;
	private Date completionDate;
	private int errandId;
	private Address address_id;
	
	public Task(){}
	
	public Task(int id, String name, String description, Date startDate, Date completionDate, int errandId,
			Address address_id) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.startDate = startDate;
		this.completionDate = completionDate;
		this.errandId = errandId;
		this.address_id = address_id;
	}

	public Task(String name, String description, Date startDate, Date completionDate, int errandId,
			Address address_id) {
		super();
		this.name = name;
		this.description = description;
		this.startDate = startDate;
		this.completionDate = completionDate;
		this.errandId = errandId;
		this.address_id = address_id;
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	public Date getCompletionDate() {
		return completionDate;
	}

	public void setCompletionDate(Date completionDate) {
		this.completionDate = completionDate;
	}

	public int getErrandId() {
		return errandId;
	}

	public void setErrandId(int errandId) {
		this.errandId = errandId;
	}

	public Address getAddress_id() {
		return address_id;
	}

	public void setAddress_id(Address address_id) {
		this.address_id = address_id;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
