package daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import entities.Address;
import entities.Errand;
import entities.Reward;
import entities.Task;
import utils.DatabaseManager;

public class TasksDao extends DatabaseManager{
	
	/** Defines a query that adds a task entry into the database */
	private static final String insertTask= "INSERT INTO tasks (name, description, errandId, addressesId) VALUES (?, ?, ?, ?)";
	
	private static final String select_latestTask = "SELECT * from tasks order by date_completed desc join on addresses using(address_id)"; 
	private static final String select_tasksForErrand = "SELECT * FROM tasks where errandID = ?";
	private static AddressDAO addressDB = new AddressDAO();
	
	/**
	 * Inserts a new entry into the database, returning the auto-generated id
	 * @param task The model data to map to the database entry
	 * @return The auto-assigned id of the created object, -1 on failure
	 */
	public int addTask(Task task) {
		int taskId = -1;
		
		Object[] taskData = {
			task.getName(),
			task.getDescription(),
			task.getErrandId(),
			(task.getAddress_id().getId() == 0 ? 0 : task.getAddress_id().getId())
		};
		
		try {
			taskId = insert(insertTask, taskData);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return taskId;
	}
	
	public Task getLastCompletedTask(){
		try(ResultSet rs = query(select_latestTask)){
			if(rs.next())
				return new Task(
							
						);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return null;
	}
	
	public List<Task> getTasksForErrand(int errandID){
		List<Task> tasks = new ArrayList<Task>();
		try(ResultSet rs = query(select_tasksForErrand, errandID)){
			while(rs.next()){
				tasks.add(new Task(
						rs.getInt("id"), 
						rs.getString("name"), 
						rs.getString("description"),
						rs.getDate("startDate"),
						rs.getDate("completionDate"), 
						rs.getInt("errandId"),
						addressDB.getAddress(rs.getInt("addressesId"))
					));
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return tasks;
	}
}

