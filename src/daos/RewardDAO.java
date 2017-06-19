package daos;

import java.sql.ResultSet;
import java.sql.SQLException;

import entities.Errand;
import entities.Reward;
import entities.Errand.ImportanceType;
import entities.Errand.StatusType;
import utils.DatabaseManager;

public class RewardDAO extends DatabaseManager{
	
	/** Defines a query that selects a reward entity by its id */
	private static final String select_RewardForID = 
			"SELECT * FROM rewards WHERE id = ?";
	
	/** Defines a query that adds a reward entry into the database */
	private static final String insertReward = 
			"INSERT INTO rewards (name, rewardValue, description) VALUES (?, ?, ?)";
	
	/**
	 * 
	 * @param id
	 * @return
	 */
	public Reward getRewardForID(int id){
		Reward reward = null;
		try(ResultSet rs = query(select_RewardForID, Integer.toString(id));){
			if(rs.next())
				reward = new Reward(
						rs.getInt("id"),
						rs.getString("name"),
						rs.getInt("rewardValue"),
						rs.getString("description")
					);
		}
		catch (SQLException e){
			e.printStackTrace();
			return null;
		}
		return reward;
	}
	
	/**
	 * Inserts a new entry into the database, returning the auto-generated id
	 * @param reward The model data to map to the database entry
	 * @return The auto-assigned id of the created object, -1 on failure
	 */
	public int addReward(Reward reward) {
		int rewardId = -1;
		
		Object[] rewardData = {
			reward.getName(),
			reward.getRewardValue(),
			reward.getDescription()
		};
		
		try {
			rewardId = insert(insertReward, rewardData);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return rewardId;
	}
}
