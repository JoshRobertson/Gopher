package daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entities.Address;
import entities.Address.AddressType;
import utils.DatabaseManager;

/**
 * Class which interacts with the database to create address objects.
 * 
 */
public class AddressDAO extends DatabaseManager{

	private static UserDao userDB = new UserDao();
	/**
	 * Query for all rows with matching userId
	 */
	private static final String SELECT_ALL_ADDRESSES_BY_USERID = "SELECT * FROM addresses WHERE userId = ?";
	private static final String SELECT_ADDRESS_BY_ADDRESSID = "SELECT * FROM addresses WHERE id = ?";
	private static final String INSERT_ADDRESS = 
			"INSERT INTO addresses (addressLine1, addressLine2, city, province, country, zip, latitude, longitude, userId, addressTypeId) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE_ADDRESS = "UPDATE addresses SET addressLine1=?, addressLine2=?, city=?, province=?, country=?, zip=?, lat=?, long=?, addressType=? WHERE id=?";
	
	
	/**
	 * Returns All addresses belonging to the user with the matching userId
	 * @param userId
	 * @return All addresses with the matching userId
	 */
	public List<Address> getAddresses(int userId){
		List<Address> addresses = new ArrayList<>();
		try (ResultSet rs = query(SELECT_ALL_ADDRESSES_BY_USERID, Integer.toString(userId))) {
			while (rs.next()) {
				addresses.add(mapData(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return addresses;
	}
	
	/**
	 * Returns All addresses belonging to the user with the matching userId
	 * @param userId
	 * @return All addresses with the matching userId
	 */
	public Address getAddress(int addressID){
		Address address = null;
		try (ResultSet rs = query(SELECT_ADDRESS_BY_ADDRESSID, Integer.toString(addressID))) {
			if(rs.next()){
				address = new Address(rs.getInt("id"),
						rs.getString("addressLine1"),
						rs.getString("addressLine2"),
						rs.getString("city"),
						rs.getString("province"),
						rs.getString("country"),
						rs.getString("zip"),
						rs.getDouble("latitude"),
						rs.getDouble("longitude"),
						rs.getInt("userId"),
						AddressType.getAddressType(rs.getInt("addressTypeId")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return address;
	}
	/**
	 * Updates an Address
	 * @param addressLine1
	 * @param addressLine2
	 * @param city
	 * @param province
	 * @param country
	 * @param zip
	 * @param addressType
	 * @param addressId
	 * @return The number of rows affected
	 */
	public int updateAddress(Address address){		
		try {
			return update(
				UPDATE_ADDRESS, 
				address.getAddressLine1(),
				address.getAddressLine2(),
				address.getCity(),
				address.getProvince(),
				address.getCountry(),
				address.getZip(),
				address.getLat(),
				address.getLon(),
				address.getId()			
			);
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}		
		return -1;
	}
	
	
	/**
	 * Inserts a new address into the database
	 * @param Address Object
	 * @return The ID of the inserted address
	 */
	public int addAddress(Address address) {
		int addressId = -1;
		Object[] addressData = {
				address.getAddressLine1(),
				address.getAddressLine2(),
				address.getCity(),
				address.getProvince(),
				address.getCountry(),
				address.getZip(),
				address.getLat(),
				address.getLon(),
				address.getUserId(),
				1	// default to addressTypeId of 1 for now (not used in application)
			};
		
		try {
			addressId = insert(INSERT_ADDRESS, addressData);		
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}	
		return addressId;
	}
	
	
	/**
	 * Address object created using a ResultSet
	 * @param The result set to be used
	 * @return Address from the result set
	 * @throws SQLException in case of database error
	 */
	private static Address mapData(ResultSet rs) throws SQLException {
		return new Address(
			rs.getInt("id"),
			rs.getString("addressLine1"),
			rs.getString("addressLine2"),
			rs.getString("city"),
			rs.getString("province"),
			rs.getString("country"),
			rs.getString("zip"),
			rs.getDouble("latitude"),
			rs.getDouble("longitude"),
			rs.getInt("userId"),
			AddressType.getAddressType(rs.getInt("addressTypeId"))					
		);				
	}
	
}