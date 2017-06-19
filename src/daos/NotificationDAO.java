package daos;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import entities.Notification;
import entities.Notification.NotificationType;
import entities.Rating;
import utils.DatabaseManager;

public class NotificationDAO extends DatabaseManager{
	private UserDao userDao = new UserDao();
	
	private static final String select_AllNotification = "SELECT * FROM notifications";
	
	/** Defines a query that selects all notifications for a single user by user id */
	private static final String selectNotificationsByUserId = "SELECT * FROM notifications WHERE userId = ?";
	
	public NotificationDAO(){}
	
	/**
	 * Returns a list of all notifications given to the User specified by userId
	 * @param userId The id of the user for which to return the notifications
	 * @return a list of Notification objects associated with the specified User
	 */
	public List<Notification> getNotificationsByUserId(int userId) {
		List<Notification> notifications = new ArrayList<>();
		
		try (ResultSet rs = query(selectNotificationsByUserId, Integer.toString(userId))) {
			while (rs.next()) {
				notifications.add(mapData(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();	// Handle this eventually
		}
		
		return notifications;
	}
	
	/**
	 * Helper method that maps the data from the specified ResultSet to a Notifications model object
	 * @param rs the ResultSet to be mapped to a Notifications object
	 * @return The Notification with data mapped from the ResultSet
	 * @throws SQLException if an error occurs when accessing db
	 */
	private Notification mapData(ResultSet rs) throws SQLException {
		Notification notification = new Notification(
				rs.getString("title"),
				userDao.getUserForID(rs.getInt("userId")),
				rs.getString("message"),
				NotificationType.getNotificationType(rs.getInt("notificationTypeId"))
				);
		
		return notification;
	}	
}
