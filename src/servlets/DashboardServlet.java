package servlets;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.ErrandDao;
import daos.NotificationDAO;
import daos.RatingDAO;
import daos.UserDao;
import entities.User;
import entities.User.UserType;
import entities.Errand;
import entities.Notification;
import entities.Rating;

/**
 * Servlet implementation class DashboardServlet
 * @author skyet
 */
@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
	
	private static final long serialVersionUID = -2915114669209009394L;
	private User user;
	private ErrandDao errandDao = new ErrandDao();
	private RatingDAO ratingDao = new RatingDAO();
	private NotificationDAO notifDao = new NotificationDAO();
	
	/** @see HttpServlet#HttpServlet() */
    public DashboardServlet() {
        super();
    }
    
	/** @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response) */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		// If user isn't logged in, redirect them to login page
		if (session.getAttribute("loggedIn") == null) {
			try {
				response.sendRedirect("/login");
				return;
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// If user is logged in, continue
		user = (User) session.getAttribute("userObject");
		
		// Retrieve active errands for which the user is a Customer (requests)
		List<Errand> errandsCustomer = errandDao.selectErrandsForUser(user);
		
		// Active errands for which the user is a Gopher
		List<Errand> errandsGopher = errandDao.selectErrandsForGopherId(user);
		
		// Completed errands for which the user is a Customer (requests)
		List<Errand> completedErrandsCustomer = errandDao.selectCompletedErrandsForUser(user);
				
		// Completed errands for which the user is a Gopher
		List<Errand> completedErrandsGopher = errandDao.selectCompletedErrandsForGopher(user);
		
		// All ratings for the user as a Customer
		List<Rating> ratingsCustomer = ratingDao.getAllCustomerRatingsById(user.getId());
		
		// Average rating for the user as a Customer
		Integer customerRatingAvg = ratingDao.getRatingAverageForCustomerID(user.getId());
		
		// All ratings for the user as a Gopher
		List<Rating> ratingsGopher = ratingDao.getAllGopherRatingsById(user.getId());
						
		// Average rating for the user as a Gopher
		Integer gopherRatingAvg = ratingDao.getRatingAverageForGopherID(user.getId());
		
		// Retreive all notifications for user
		List<Notification> notifs = notifDao.getNotificationsByUserId(user.getId());
		
		try {
			request.setAttribute("errandsCustomer", errandsCustomer);
			request.setAttribute("errandsGopher", errandsGopher);
			request.setAttribute("completedErrandsCustomer", completedErrandsCustomer);
			request.setAttribute("completedErrandsGopher", completedErrandsGopher);
			request.setAttribute("ratingsCustomer",  ratingsCustomer);
			request.setAttribute("customerRatingAvg", customerRatingAvg);
			request.setAttribute("ratingsGopher", ratingsGopher);
			request.setAttribute("gopherRatingAvg", gopherRatingAvg);
			request.setAttribute("notifs", notifs);
			request.getRequestDispatcher("WEB-INF/dashboard.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

	/** @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response) */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) {
		//doGet(request, response);
	}

}
