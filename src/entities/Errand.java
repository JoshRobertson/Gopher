package entities;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import entities.Errand.ImportanceType;
import entities.Errand.StatusType;

/**
 * This class represents a model of Errand data
 * It acts as the domain-specific class that the application
 * will use to represent the "transactions" table of the database
 * @author skyet
 *
 */
public class Errand implements Serializable {
	private static final long serialVersionUID = -2691284966379819188L;

	private int id;								// Unique id of the errand
	private User user_id_customer;				// Customer associated with the errand
	private User user_id_gopher;				// Gopher associated with the errand
	private Date dateCreated;					// Date the errand was created
	private Date dateCompleted;					// Date the errand was completed
	private ImportanceType importanceTypeID;
	private List<Task> tasks;					// List of tasks involved in the errand
	private Reward rewardId;						// Reward for completing this errand
	private Date deadline;					// Due date/time for errand
	private StatusType status;						// Ongoing progress status
	private String name;
	private String description;
	
	public enum ImportanceType{
		VERY_HIGH("Very High",5),
		HIGH("High",4),
		NORMAL("Normal",3),
		LOW("Low", 2),
		VERY_LOW("Very Low", 1);
		
		private String name;
		private int index;
		
		private ImportanceType(String name, int index){
			this.name = name;
			this.index = index;
		}
		
		public static ImportanceType getImportanceType(int index){
			for(ImportanceType type : ImportanceType.values())
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
	
	public enum StatusType{
		COMPLETED(1, "Completed"),
		NOT_STARTED(2, "Not Started"),
		IN_PROGRESS(3, "In Progress");
		
		private String name;
		private int index;
		
		private StatusType(int index, String name){
			this.name = name;
			this.index = index;
		}
		
		public static StatusType getStatusType(int index){
			for(StatusType type : StatusType.values())
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
	
	public Errand(){};
	
	
	
	public Errand(int id, User user_id_customer, User user_id_gopher, Date dateCreated, Date dateCompleted,
			ImportanceType importanceTypeID, List<Task> tasks, Reward rewardId, Date deadline, StatusType status,
			String name, String description) {
		this.id = id;
		this.user_id_customer = user_id_customer;
		this.user_id_gopher = user_id_gopher;
		this.dateCreated = dateCreated;
		this.dateCompleted = dateCompleted;
		this.importanceTypeID = importanceTypeID;
		this.tasks = tasks;
		this.rewardId = rewardId;
		this.deadline = deadline;
		this.status = status;
		this.name = name;
		this.description = description;
	}



	public Errand(int id,String name, String description, Date dateCreated, Date dateCompleted, Timestamp deadline, Reward reward, StatusType status, ImportanceType importance, User user_id_cusomter, User user_id_gopher){
		this.id = id;
		this.name = name;
		this.description = description;
		this.user_id_customer = user_id_cusomter;
		this.user_id_gopher = user_id_gopher;
		this.dateCreated = dateCreated;
		this.rewardId = reward;
		this.setDeadline(deadline);
		this.setStatus(status);
		this.setImportance(importance);
	}
	
	public Errand(int id,String name, String description, List<Task> tasks, Date dateCreated, Date dateCompleted, Timestamp deadline, Reward reward, StatusType status, ImportanceType importance, User user_id_cusomter, User user_id_gopher){
		this.id = id;
		this.name = name;
		this.tasks = tasks;
		this.description = description;
		this.user_id_customer = user_id_cusomter;
		this.user_id_gopher = user_id_gopher;
		this.dateCreated = dateCreated;
		this.rewardId = reward;
		this.setDeadline(deadline);
		this.setStatus(status);
		this.setImportance(importance);
	}

	public Errand(String name, String description, Date deadline, ImportanceType importanceType, User customer, Reward reward) {
		this.name = name;
		this.description = description;
		this.deadline = deadline;
		this.importanceTypeID = importanceType;
		this.user_id_customer = customer;
		this.rewardId = reward;
	}

	// Getters
	public int getId() {
		return id;
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

	public User getUserIdCustomer() {
		return user_id_customer;
	}
	public User getUserIdGopher() {
		return user_id_gopher;
	}
	public Date getDateCreated() {
		return dateCreated;
	}
	public Date getDateCompleted() {
		return dateCompleted;
	}
	public List<Task> getTasks() {
		return tasks;
	}
	public Reward getRewardId() {
		return rewardId;
	}
	public StatusType getStatus() {
		return status;
	}
	public Date getDeadline() {
		return deadline;
	}	
	public ImportanceType getImportanceTypeID() {
		return importanceTypeID;
	}
	
	// Setters
	public void setId(int id) {
		this.id = id;
	}
	public void setUserIdCustomer(User user_id_customer) {
		this.user_id_customer = user_id_customer;
	}
	public void setUserIdGopher(User user_id_gopher) {
		this.user_id_gopher = user_id_gopher;
	}
	public void setDateCreated(Date dateCreated) {
		this.dateCreated = dateCreated;
	}
	public void setDateCompleted(Date dateCompleted) {
		this.dateCompleted = dateCompleted;
	}
	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}
	public void setRewardId(Reward rewardId) {
		this.rewardId = rewardId;
	}	
	public void setStatus(StatusType status) {
		this.status = status;
	}
	public void setDeadline(Timestamp deadline) {
		this.deadline = deadline;
	}
	public void setImportance(ImportanceType importanceTypeId) {
		this.importanceTypeID = importanceTypeId;
	}
}