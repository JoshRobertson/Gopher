package entities;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import entities.Address.AddressType;
import entities.User.UserType;

/**
 * This class represents a model of User data
 * It acts as the domain-specific class that the application
 * will use to represent the "users" table of the database
 * @author skyet
 *
 */
public class User implements Serializable {

	private static final long serialVersionUID = -6205863538753164722L;

	// Fields
	private int id;					
	private String nameFirst;		
	private String nameLast;
	private String username;
	private String email;
	private String phoneHome;
	private String phoneMobile;
	private String phoneWork;
	private String password;
	private Date dateJoined;
	private UserType userTypeId;
	
	public enum UserType{
		GOHPER("Gopher", 1),
		ADMIN("Admin", 2),
		CUSTOMER("Customer", 3);
		
		private String name;
		private int index;
		
		private UserType(String name, int index){
			this.name = name;
			this.index = index;
		}
		
		public static UserType getUserType(int index){
			for(UserType type : UserType.values())
				if(type.index == index) return type;
			return null;
		}
		
		public String getTitle(){
			return name;
		}
		
		public int getIndex(){
			return this.index;
		}
	}
	public User(){}

	public User(int id, String nameFirst, String nameLast, String username, String email, String phoneHome, String phoneMobile,
			String phoneWork, String password, Timestamp dateJoined, UserType userTypeId) {
		super();
		this.id = id;
		this.nameFirst = nameFirst;
		this.nameLast = nameLast;
		this.username = username;
		this.email = email;
		this.phoneHome = phoneHome;
		this.phoneMobile = phoneMobile;
		this.phoneWork = phoneWork;
		this.password = password;
		this.dateJoined = dateJoined;
		this.userTypeId = userTypeId;
	}

		public User(int id, String nameFirst, String nameLast, String username, String email, String phoneHome, String phoneMobile,
			String phoneWork, Date dateJoined, UserType userTypeId) {
		super();
		this.id = id;
		this.nameFirst = nameFirst;
		this.nameLast = nameLast;
		this.username = username;
		this.email = email;
		this.phoneHome = phoneHome;
		this.phoneMobile = phoneMobile;
		this.phoneWork = phoneWork;
		this.dateJoined = dateJoined;
		this.userTypeId = userTypeId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNameFirst() {
		return nameFirst;
	}

	public void setNameFirst(String nameFirst) {
		this.nameFirst = nameFirst;
	}

	public String getNameLast() {
		return nameLast;
	}

	public void setNameLast(String nameLast) {
		this.nameLast = nameLast;
	}

	public String getUsername() {
		return this.username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhoneHome() {
		return phoneHome;
	}

	public void setPhoneHome(String phoneHome) {
		this.phoneHome = phoneHome;
	}

	public String getPhoneMobile() {
		return phoneMobile;
	}

	public void setPhoneMobile(String phoneMobile) {
		this.phoneMobile = phoneMobile;
	}

	public String getPhoneWork() {
		return phoneWork;
	}

	public void setPhoneWork(String phoneWork) {
		this.phoneWork = phoneWork;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getDateJoined() {
		return dateJoined;
	}

	public void setDateJoined(Timestamp dateJoined) {
		this.dateJoined = dateJoined;
	}

	public UserType getUserTypeId() {
		return userTypeId;
	}

	public void setUserTypeId(UserType userTypeId) {
		this.userTypeId = userTypeId;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
}
