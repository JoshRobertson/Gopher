package entities;

import java.io.Serializable;

import entities.Errand.ImportanceType;

/**
 * This class represents a model for addresses
 * It acts as the domain-specific class that the application
 * will use to represent the "addresses" table of the database
 * @author skyet
 *
 */
public class Address implements Serializable {
	private static final long serialVersionUID = -3615245129407389786L;
	
	private int id;
	private String addressLine1;
	private String addressLine2;
	private String city;
	private String province;
	private String country;
	private String zip;
	private double latitude;
	private double logitude;
	private int userId;
	private AddressType addressType;
	
	
	public enum AddressType{
		HOME("Home", 1),
		WORK("Work", 2),
		PICKUP_LOCATION("Pickup Location", 3),
		MEETING_LOCATION("Meeting Location", 4),
		DROPOFF_LOCATION("Dropoff Location", 5),
		CUSTOM_TYPE("Custom Type", 6);
		
		private String name;
		private int index;
		
		private AddressType(String name, int index){
			this.name = name;
			this.index = index;
		}
		
		public static AddressType getAddressType(int index){
			for(AddressType type : AddressType.values())
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

	public Address(int id, String addressLine1, String addressLine2, String city, String province, String country, String zip, double lat, double lon, int userId, AddressType addressType) {
		super();
		this.id = id;
		this.addressLine1 = addressLine1;
		this.addressLine2 = addressLine2;
		this.city = city;
		this.province = province;
		this.country = country;
		this.zip = zip;
		this.latitude = lat;
		this.logitude = lon;
		this.userId = userId;
		this.addressType = addressType;
	}
	
	public Address(String addressLine1, String addressLine2, String city, String province, String country, String zip, double lat, double lon, int userId) {
		super();
		this.addressLine1 = addressLine1;
		this.addressLine2 = addressLine2;
		this.city = city;
		this.province = province;
		this.country = country;
		this.zip = zip;
		this.latitude = lat;
		this.logitude = lon;
		this.userId = userId;
	}

	public int getId() {
		return id;
	}


	public void setId(int id) {
		this.id = id;
	}


	public String getAddressLine1() {
		return addressLine1;
	}


	public void setAddressLine1(String addressLine1) {
		this.addressLine1 = addressLine1;
	}


	public String getAddressLine2() {
		return addressLine2;
	}


	public void setAddressLine2(String addressLine2) {
		this.addressLine2 = addressLine2;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}


	public String getProvince() {
		return province;
	}


	public void setProvince(String province) {
		this.province = province;
	}


	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	public String getZip() {
		return zip;
	}


	public void setZip(String zip) {
		this.zip = zip;
	}


	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public AddressType getAddressType() {
		return addressType;
	}


	public void setAddressType(AddressType addressType) {
		this.addressType = addressType;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public double getLat() {
		return latitude;
	}

	public void setLat(double lat) {
		this.latitude = lat;
	}

	public double getLon() {
		return logitude;
	}

	public void setLon(double lon) {
		this.logitude = lon;
	}
	
	@Override
	public String toString(){
		StringBuilder sb = new StringBuilder();
		sb.append(this.addressLine1 + "\n");
		sb.append(this.addressLine2 + "\n");
		sb.append(this.city + "\n");
		sb.append(this.province + "\n");
		return this.addressLine1 +"\n" + addressLine2;
	}
}