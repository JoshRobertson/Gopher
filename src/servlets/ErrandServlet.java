package servlets;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import daos.ErrandDao;
import daos.RatingDAO;
import daos.UserDao;
import entities.Errand;
import entities.Errand.StatusType;
import entities.Rating;
import entities.User;

public class ErrandServlet extends javax.servlet.http.HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private ErrandDao errandDB = new ErrandDao();
	private RatingDAO ratingDAO = new RatingDAO();
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response){
		User currentUser = (User)request.getSession().getAttribute("userObject");
		Errand errand = errandDB.selectById(Integer.parseInt(request.getParameter("id")));
		
		if(errand.getStatus() == StatusType.IN_PROGRESS && currentUser.getId() == errand.getUserIdGopher().getId()){
			errand.setStatus(StatusType.COMPLETED);
			errand.setDateCompleted(Date.valueOf(LocalDate.now()));
			errandDB.updateErrand(errand);
		}else if(errand.getStatus() == StatusType.NOT_STARTED && errand.getUserIdGopher() == null){
			errand.setStatus(StatusType.IN_PROGRESS);
			errand.setUserIdGopher(currentUser);
			System.out.println("what");
			errandDB.updateErrand(errand);
		}
		try {
			response.sendRedirect("errand?id="+errand.getId());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		HttpSession session = request.getSession();
		if(session.getAttribute("userObject") == null){
			response.sendRedirect("/login");
			return;
		}
		try {
			//request.setAttribute("errand", errand);
			Errand errand = errandDB.selectById((Integer.parseInt(request.getParameter("id"))));
			System.out.println(errand);
			request.setAttribute("errand", errand);
			
			// Get all ratings for the customer who requested the errand
			List<Rating> ratings = ratingDAO.getAllCustomerRatingsById(errand.getUserIdCustomer().getId());
			request.setAttribute("ratingsList", ratings);
			
			// Get the average rating for the customer who requested the errand
			Integer customerRatingAvg = ratingDAO.getRatingAverageForCustomerID(errand.getUserIdCustomer().getId());
			request.setAttribute("customerAverage", customerRatingAvg);
			
			//Check if current session user is the gopher for the errand
			User currentUser = (User)request.getSession().getAttribute("userObject");

			if (errand.getUserIdGopher() != null && currentUser.getId() == errand.getUserIdGopher().getId())
				request.setAttribute("currentUserIsGopher", true);
			else 
				request.setAttribute("currentUserIsGopher", false);
			
			if(currentUser.getId() == errand.getUserIdCustomer().getId()){
				request.setAttribute("currentUserIsCustomer", true);
			}else{
				request.setAttribute("currentUserIsCustomer", false);
			}
			request.getRequestDispatcher("WEB-INF/errand.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}

}