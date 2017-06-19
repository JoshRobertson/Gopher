package daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entities.Rating;
import entities.User;
import utils.DatabaseManager;

/**
 * Defines all actions that may be performed on the Rating model class.
 * Maps the Rating model to the ratings db table.
 * @author skyet
 */
public class RatingDAO extends DatabaseManager {
	
	private UserDao userDao = new UserDao();
	private ErrandDao errandDao = new ErrandDao();
	
	/** Defines a query that selects all ratings ordered them by newest first */
	private static final String selectAllRatings = 
			"SELECT * FROM ratings ORDER BY creationDate desc";
	
	/** Defines a query that selects all ratings for a single user by user id */
	private static final String selectUserRatingsByUserId = 
			"SELECT * FROM ratings WHERE user_rated_id = ? ORDER BY date_created desc";
	
	/** Defines a query that selects all ratings made by a single user by user id */
	private static final String selectContributedRatingsByUserId = 
			"SELECT * FROM ratings WHERE user_rater_id = ? ORDER BY date_created desc";
	
	/** Defines a query that selects all Customer ratings for a user by user id */
	private static final String selectAllRatingsForCustomer = 
			"SELECT * FROM ratings, errands WHERE ratings.userIdRated = errands.userIdCustomer "
			+ "AND errandId = errands.id AND userIdCustomer = ? ORDER BY ratings.creationDate DESC;";
	
	/** Defines a query that selects all Gopher ratings for a user by user id */
	private static final String selectAllRatingsForGopher = 
			"SELECT * FROM ratings, errands WHERE ratings.userIdRated = errands.userIdGopher "
			+ "AND errandId = errands.id AND userIdGopher = ? ORDER BY ratings.creationDate DESC;";
	
	/** Defines a query that selects all ratings associated with an errand by errand id @author justin */
	private static final String selectAllRatingsForErrand = 
			"SELECT * FROM ratings where errandId = ? ORDER BY creationDate DESC";
	
	/** Define a query that retrieves the average rating value for an errand by errand id @author justin */
	private static final String selectRatingAverageForErrandID =
			"SELECT avg(ratingValue) FROM ratings WHERE errandId=?";
	
	/** Define a query that retrieves the average rating value for a Customer by id (rounded to nearest integer)*/
	private static final String selectRatingAverageForCustomerID =
			"SELECT ROUND(avg(ratingValue)) FROM ratings, errands WHERE ratings.userIdRated = errands.userIdCustomer "
			+ "AND errandId = errands.id AND userIdCustomer = ?";
	
	/** Define a query that retrieves the average rating value for a Gopher by id (rounded to nearest integer)*/
	private static final String selectRatingAverageForGopherID =
			"SELECT ROUND(avg(ratingValue)) FROM ratings, errands WHERE ratings.userIdRated = errands.userIdGopher "
			+ "AND errandId = errands.id AND userIdGopher = ?";
	
	/** Defines a query that adds a rating entry into the database */
	private static final String insertRating = 
			"INSERT INTO ratings ( user_rated_id, user_rater_id, errand_id, rating, comments )"
			+ "VALUES ( ?, ?, ?, ?, ? )";
	
	/** Defines a query that updates the rating value and comments of an entry by id */
	private static final String updateRatingById = 
			"UPDATE ratings SET rating = ?, comments = ? WHERE id = ?";

	
	/**
	 * Returns a list of all ratings from the database ordered by most recent
	 * @return List of Rating objects
	 */
	public List<Rating> getAllRatings() {
		List<Rating> ratings = new ArrayList<>();
		
		try (ResultSet rs = query(selectAllRatings)){
			while (rs.next()) {
				ratings.add(mapData(rs));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return ratings;
	}
	
	
	/**
	 * Returns a list of all ratings given to the User specified by userId
	 * @param userId The id of the user for which to return the ratings
	 * @return a list of Rating objects associated with the specified User
	 */
	public List<Rating> getUserRatingsById(int userId) {
		List<Rating> ratings = new ArrayList<>();
		
		try (ResultSet rs = query(selectUserRatingsByUserId, Integer.toString(userId))) {
			while (rs.next()) {
				ratings.add(mapData(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return ratings;
	}
	
	
	/**
	 * Returns a list of ratings that were made by the User specified by userId
	 * @param userId The id of the User for which to return the contributed ratings
	 * @return a list of Rating objects that were made by the specified User
	 */
	public List<Rating> getRatingsMadeById(int userId) {
		List<Rating> ratings = new ArrayList<>();
		
		try (ResultSet rs = query(selectContributedRatingsByUserId, Integer.toString(userId))) {
			while (rs.next()) {
				ratings.add(mapData(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return ratings;
	}
	
	
	/**
	 * Returns a list of all ratings given to a user who acted as a Customer
	 * @param id the id of the user
	 * @return a List of Rating objects
	 */
	public List<Rating> getAllCustomerRatingsById(int id) {
		List<Rating> ratings = new ArrayList<>();
		
		try (ResultSet rs = query(selectAllRatingsForCustomer, id)) {
			while (rs.next()) {
				ratings.add(mapData(rs));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return ratings;
	}
	
	/**
	 * Returns a list of all ratings given to a user who acted as a Gopher
	 * @param id the id of the user
	 * @return a List of Rating objects
	 */
	public List<Rating> getAllGopherRatingsById(int id) {
		List<Rating> ratings = new ArrayList<>();
		
		try (ResultSet rs = query(selectAllRatingsForGopher, id)) {
			while (rs.next()) {
				ratings.add(mapData(rs));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return ratings;
	}
	
	
	/**
	 * Inserts a new entry into the database
	 * @param rating The model data to map to the database entry
	 * @return The number of rows updated
	 */
	public int addRating(Rating rating) {	
		int result = -1;
		
		Object[] ratingData = {
			rating.getUserIdRated(),
			rating.getUserIdRater(),
			rating.getErrandId(),
			rating.getRatingValue(),
			rating.getComments()
		};
		
		try {
			result = update(insertRating, ratingData);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	/**
	 * Updates an entry with a new rating value and new comment string.
	 * @param newRatingValue The new value to insert as the User rating
	 * @param newComments The new comments entered by the User making the rating
	 * @param ratingId The id of the rating entry to be updated
	 * @return The number of rows effected
	 */
	public int editRating(int newRatingValue, String newComments, int ratingId) {
		int result = -1;
		
		try {
			result = update(updateRatingById, 
					Integer.toString(newRatingValue),
					newComments,
					Integer.toString(ratingId)
					);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * Returns a list of all ratings from the database ordered by most recent
	 * @return List of Rating objects
	 * @author justin
	 */
	public List<Rating> getAllRatingsForErrandID(int id) {
		List<Rating> ratings = new ArrayList<>();
		
		try (ResultSet rs = query(selectAllRatingsForErrand, id)){
			while (rs.next()) {
				ratings.add(mapData(rs));
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return ratings;
	}
	
	
	/**
	 * Returns a list of all ratings associated with an errand
	 * @param id the id of the errand to retrieve the ratings for
	 * @return List of Rating objects if they exists, Float.MIN_VALUE
	 * if there are no ratings for that errand
	 * @author justin
	 */
	public float getRatingAverageForErrandID(int id) {
	
		try (ResultSet rs = query(selectRatingAverageForErrandID, id)){
			if (rs.first()) {
				return rs.getFloat("avg(ratingValue)");
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return Float.MIN_VALUE;
	}
	
	/**
	 * Returns the average of all ratings associated with a Customer, rounded
	 * to the nearest integer
	 * @param id the id of the customer to retrieve the average ratings for
	 * @return int average of Rating objects if they exists, Integer.MIN_VALUE
	 * if there are no ratings for that customer
	 */
	public int getRatingAverageForCustomerID(int id) {
	
		try (ResultSet rs = query(selectRatingAverageForCustomerID, id)){
			if (rs.first()) {
				return rs.getInt("ROUND(avg(ratingValue))");
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return Integer.MIN_VALUE;
	}
	
	/**
	 * Returns the average of all ratings associated with a Gopher, rounded
	 * to the nearest integer
	 * @param id the id of the Gopher to retrieve the average ratings for
	 * @return int average of Rating objects if they exists, Integer.MIN_VALUE
	 * if there are no ratings for that Gopher
	 */
	public int getRatingAverageForGopherID(int id) {
	
		try (ResultSet rs = query(selectRatingAverageForGopherID, id)){
			if (rs.first()) {
				return rs.getInt("ROUND(avg(ratingValue))");
			}
		}
		catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return Integer.MIN_VALUE;
	}
	
	
	/**
	 * Helper method that maps the data from the specified ResultSet to a Rating model object
	 * @param rs the ResultSet to be mapped to a Rating
	 * @return The Rating with data mapped from the ResultSet
	 * @throws SQLException if an error occurs when accessing db
	 */
	private Rating mapData(ResultSet rs) throws SQLException {
		Rating rating = new Rating();
		
		rating.setId(rs.getInt("id"));
		rating.setUserIdRated(userDao.getUserForID(rs.getInt("userIdRated")));
		rating.setUserIdRater(userDao.getUserForID(rs.getInt("userIdRater")));
		rating.setRatingValue(rs.getInt("ratingValue"));
		rating.setErrandId(errandDao.selectById(rs.getInt("errandId")));
		rating.setComments(rs.getString("comments"));
		rating.setCreationDate(rs.getDate("creationDate"));
		
		return rating;
	}
	
}
