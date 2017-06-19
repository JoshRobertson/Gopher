package entities;

import java.io.Serializable;
import java.util.Date;

/**
 * This class represents a model for user ratings
 * It acts as the domain-specific class that the application
 * will use to represent the "ratings" table of the database
 * @author skyet
 *
 */
public class Rating implements Serializable {
	private static final long serialVersionUID = 4562427898201605236L;
	private int id;
	private User userIdRated;
	private User userIdRater;
	private int ratingValue;
	private Errand errandId;
	private String comments;
	private Date creationDate;
	
	public Rating(){
		
	}
	
	public Rating(int id, User userIdRated, User userIdRater, int ratingValue, Errand errandId, String comments,
			Date creationDAte) {
		super();
		this.id = id;
		this.userIdRated = userIdRated;
		this.userIdRater = userIdRater;
		this.ratingValue = ratingValue;
		this.errandId = errandId;
		this.comments = comments;
		this.creationDate = creationDAte;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public User getUserIdRated() {
		return userIdRated;
	}
	public void setUserIdRated(User userIdRated) {
		this.userIdRated = userIdRated;
	}
	public User getUserIdRater() {
		return userIdRater;
	}
	public void setUserIdRater(User userIdRater) {
		this.userIdRater = userIdRater;
	}
	public int getRatingValue() {
		return ratingValue;
	}
	public void setRatingValue(int ratingValue) {
		this.ratingValue = ratingValue;
	}
	public Errand getErrandId() {
		return errandId;
	}
	public void setErrandId(Errand errandId) {
		this.errandId = errandId;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public Date getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(Date creationDAte) {
		this.creationDate = creationDAte;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}