package daos;

import utils.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entities.Address;
import entities.Errand;
import entities.Rating;
import entities.Errand.ImportanceType;
import entities.Errand.StatusType;
import entities.User.UserType;
import entities.User;
/**
 * 
 * @author joshr
 *
 */
public class ErrandDao extends DatabaseManager {
	private static final String DELETE = "DELETE FROM Errands WHERE id=?";
	private static final String SELECT_ALL = "SELECT * FROM errands";
	private static final String SELECT_ALL_ACTIVE = "SELECT * FROM errands where statusTypeId = 2"; //2 == not started
	private static final String SELECT_ALL_HIGH_VERY_HIGH = "SELECT * FROM errands where statusTypeId = 2 and (importanceTypeId = 4 or importanceTypeId = 5)";
	private static final String SELECT_BY_ID = "SELECT * FROM errands where id = ?";
	private static final String SELECT_BY_NAME = "SELECT * FROM Errands WHERE name=?";
	private static final String INSERT = "INSERT INTO Errands(name, tel, passwd) VALUES(?, ?, ?)";
	private static final String UPDATE = "UPDATE Errands SET name=?, tel=?, passwd=? WHERE id=?";
	
	private static final String UPDATE_ERRAND = 
			"UPDATE errands SET name=?, description=?, creationDate=?, completionDate=?, deadline=?, rewardId=?, statusTypeId=?, importanceTypeId=?, userIdCustomer=?, userIdGopher=? where id = ?;";
	/** Query to retreive active errand requests that the user has made */
	private static final String SELECT_ERRANDS_FOR_USERID = 
			"SELECT * From errands join users on errands.userIdCustomer = users.id where users.id = ? and (statusTypeId = 3 or statusTypeId = 2)"; //3 == In Progress 2 == Not Started
	
	/** Query to retrieve active errands the user is gophering */
	private static final String SELECT_ERRANDS_FOR_GOPHERID = 
			"SELECT * From errands join users on errands.userIdGopher = users.id where users.id = ? and statusTypeId = 3"; //3 == In Progess
			//"SELECT * From errands join users on errands.userIdGopher = users.id where users.id = ? and completionDate is null";
	
	/** Query to retrieve errands the user has requested and that have since been completed */
	private static final String SELECT_COMPLETED_ERRANDS_FOR_USERID = 
			"SELECT * FROM errands, users WHERE errands.userIdCustomer = users.id AND userIdCustomer = ? AND statusTypeId = 1"; //1 == completed;
			//"SELECT * FROM errands, users WHERE errands.userIdCustomer = users.id AND userIdCustomer = ? AND completionDate is not null";
	
	/** Query to retrieve errand the user has completed as a gopher */
	private static final String SELECT_COMPLETED_ERRANDS_FOR_GOPHERID = 
			"SELECT * FROM errands, users WHERE errands.userIdGopher = users.id AND userIdGopher = ? AND statusTypeId = 1"; //1 == completed
			//"SELECT * FROM errands, users WHERE errands.userIdGopher = users.id AND userIdGopher = ? AND completionDate is not null";
	
	/** Defines a query that adds an errand entry into the database */
	private static final String insertErrand = 
			"INSERT INTO errands ( name, description, deadline, rewardId, statusTypeId, importanceTypeId, userIdCustomer, userIdGopher)"
			+ "VALUES ( ?, ?, ?, ?, ?, ?, ?, ?)";
	
	private static final String SELECT_12_LATEST = "SELECT * FROM errands WHERE statusTypeId = 2 ORDER BY creationDate DESC LIMIT 12";
	private UserDao userDB = new UserDao();
	private RewardDAO rewardDB = new RewardDAO();
	private TasksDao tasksDB = new TasksDao();
	
	/**
	 * Inserts a new entry into the database
	 * @param errand The model data to map to the database entry
	 * @return The ID of the errand added to the DB
	 */
	public int addErrand(Errand errand) {	
		int result = -1;
		
		Object[] errandData = {
			errand.getName(),
			errand.getDescription(),
			errand.getDeadline(),
			errand.getRewardId().getId(),
			2,		// Defaulting to a "Not Started" status upon creation
			errand.getImportanceTypeID().getIndex(),
			errand.getUserIdCustomer().getId(),
			null	// No gopher assigned yet, at errand request creation
		};
		
		try {
			result = insert(insertErrand, errandData);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	public int delete(int id) {
		try{
		Integer result = update(DELETE, Integer.toString(id));
				return result.intValue();
		}
		catch (SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public List<Errand> selectAll(){
		List<Errand> errands = new ArrayList<Errand>();
		try(ResultSet rs = query(SELECT_ALL_ACTIVE)){
			while (rs.next()){
				errands.add(new Errand(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("description"),
						rs.getDate("creationDate"),
						rs.getDate("completionDate"),
						rs.getTimestamp("deadline"),
						rewardDB.getRewardForID(rs.getInt("rewardId")),
						StatusType.getStatusType(rs.getInt("statusTypeId")),
						ImportanceType.getImportanceType(rs.getInt("importanceTypeId")),
						userDB.getUserForID(rs.getInt("userIdCustomer")),
						userDB.getUserForID(rs.getInt("userIdGopher"))					
					));
			}
			return errands;
		} catch (SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	/** Returns a list of active (incomplete) errands the user has requested */
	public List<Errand> selectErrandsForUser(User user){
		return selectErrandsForUser(SELECT_ERRANDS_FOR_USERID, user.getId());
	}
	
	/** Returns a list of active (incomplete errands the user is gophering */
	public List<Errand> selectErrandsForGopherId(User user){
		return selectErrandsForUser(SELECT_ERRANDS_FOR_GOPHERID, user.getId());
	}
	
	/** Returns a list of errands the user has requested and have been completed */
	public List<Errand> selectCompletedErrandsForUser(User user){
		return selectErrandsForUser(SELECT_COMPLETED_ERRANDS_FOR_USERID, user.getId());
	}
	
	/** Returns a list of errands the user was a gopher for and have been completed*/
	public List<Errand> selectCompletedErrandsForGopher(User user){
		return selectErrandsForUser(SELECT_COMPLETED_ERRANDS_FOR_GOPHERID, user.getId());
	}
	
	public List<Errand> selectErrandsForUser(String query, int userid){
		List<Errand> errands = new ArrayList<Errand>();
		try(ResultSet rs = query(query, userid)){
			while (rs.next()){
				errands.add(new Errand(
						rs.getInt("id"),
						userDB.getUserForID(rs.getInt("userIdCustomer")),
						userDB.getUserForID(rs.getInt("userIdGopher")),
						rs.getDate("creationDate"),
						rs.getDate("completionDate"),
						ImportanceType.getImportanceType(rs.getInt("importanceTypeId")),
						tasksDB.getTasksForErrand(rs.getInt("id")),
						rewardDB.getRewardForID(rs.getInt("rewardId")),
						rs.getDate("deadline"),
						StatusType.getStatusType(rs.getInt("statusTypeId")),
						rs.getString("name"),
						rs.getString("description")
					));
			}
			return errands;
		} catch (SQLException e){
			throw new RuntimeException(e);
		}	
	}
	
	public Errand selectById(int id){
		Errand errand = null;
		try(ResultSet rs = query(SELECT_BY_ID, Integer.toString(id));){
			if(rs.next())
				errand = new Errand(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("description"),
						tasksDB.getTasksForErrand(Integer.parseInt(rs.getString("id"))),
						rs.getDate("creationDate"),
						rs.getDate("completionDate"),
						rs.getTimestamp("deadline"),
						rewardDB.getRewardForID(rs.getInt("rewardId")),
						StatusType.getStatusType(rs.getInt("statusTypeId")),
						ImportanceType.getImportanceType(rs.getInt("importanceTypeId")),
						userDB.getUserForID(rs.getInt("userIdCustomer")),
						userDB.getUserForID(rs.getInt("userIdGopher"))
					);
		}
		catch (SQLException e){
			e.printStackTrace();
			return null;
		}
		return errand;
	}
	
	public List<Errand> select12Latest(){
		List<Errand> errands = new ArrayList<Errand>();
		try(ResultSet rs = query(SELECT_12_LATEST)){
			while (rs.next()){
				errands.add(new Errand(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("description"),
						rs.getDate("creationDate"),
						rs.getDate("completionDate"),
						rs.getTimestamp("deadline"),
						rewardDB.getRewardForID(rs.getInt("rewardId")),
						StatusType.getStatusType(rs.getInt("statusTypeId")),
						ImportanceType.getImportanceType(rs.getInt("importanceTypeId")),
						userDB.getUserForID(rs.getInt("userIdCustomer")),
						userDB.getUserForID(rs.getInt("userIdGopher"))					
					));
			}
			return errands;
		} catch (SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public List<Errand> selectAllActive(){
		List<Errand> errands = new ArrayList<Errand>();
		try(ResultSet rs = query(SELECT_ALL_ACTIVE)){
			while (rs.next()){
				errands.add(new Errand(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("description"),
						rs.getDate("creationDate"),
						rs.getDate("completionDate"),
						rs.getTimestamp("deadline"),
						rewardDB.getRewardForID(rs.getInt("rewardId")),
						StatusType.getStatusType(rs.getInt("statusTypeId")),
						ImportanceType.getImportanceType(rs.getInt("importanceTypeId")),
						userDB.getUserForID(rs.getInt("userIdCustomer")),
						userDB.getUserForID(rs.getInt("userIdGopher"))					
					));
			}
			return errands;
		} catch (SQLException e){
			throw new RuntimeException(e);
		}
	}
	
	public List<Errand> selectAllHighVeryHigh(){
		List<Errand> errands = new ArrayList<Errand>();
		try(ResultSet rs = query(SELECT_ALL_HIGH_VERY_HIGH)){
			while (rs.next()){
				errands.add(new Errand(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getString("description"),
						rs.getDate("creationDate"),
						rs.getDate("completionDate"),
						rs.getTimestamp("deadline"),
						rewardDB.getRewardForID(rs.getInt("rewardId")),
						StatusType.getStatusType(rs.getInt("statusTypeId")),
						ImportanceType.getImportanceType(rs.getInt("importanceTypeId")),
						userDB.getUserForID(rs.getInt("userIdCustomer")),
						userDB.getUserForID(rs.getInt("userIdGopher"))					
					));
			}
			return errands;
		} catch (SQLException e){
			throw new RuntimeException(e);
		}
	}
	
//"UPDATE errands SET name=?, description=?, creationDate=?, completionDate=?, deadline=?, rewardId=?, statusTypeId=?, importanceTypeId=?, userIdCustomer=?, userIdGopher=?;";
	
	public void updateErrand(Errand errand){
		try{
			update(UPDATE_ERRAND, errand.getName(),
				errand.getDescription(),
				errand.getDateCreated(),
				errand.getDateCompleted(),
				errand.getDeadline(),
				errand.getRewardId().getId(), 
				errand.getStatus().getIndex(),
				errand.getImportanceTypeID().getIndex(),
				errand.getUserIdCustomer().getId(),
				errand.getUserIdGopher().getId(),
				errand.getId());
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
}