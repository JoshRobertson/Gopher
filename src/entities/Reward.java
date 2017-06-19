package entities;

import java.io.Serializable;

/**
 * This class represents a model for errand rewards
 * It acts as the domain-specific class that the application
 * will use to represent the "rewards" table of the database
 * @author skyet
 *
 */
public class Reward implements Serializable {
	private static final long serialVersionUID = 789459184699975989L;

	private int id;
	private String name;
	private int rewardValue;
	private String description;
	
	
	public Reward(int id, String name, int rewardValue, String description) {
		super();
		this.id = id;
		this.name = name;
		this.rewardValue = rewardValue;
		this.description = description;
	}
	
	public Reward(String name, String description, int rewardValue) {
		this.name = name;
		this.description = description;
		this.rewardValue = rewardValue;	
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
	public int getRewardValue() {
		return rewardValue;
	}
	public void setRewardValue(int rewardValue) {
		this.rewardValue = rewardValue;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}	
}
