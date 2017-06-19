package servlets;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import daos.UserDao;
import entities.User;

/**
 * Class which
 * @author Justin
 *
 */
public class RegisterServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private UserDao userDAO = new UserDao();

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("WEB-INF/signup.jsp").forward(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException{
		
		HttpSession session = request.getSession();
		String username = request.getParameter("username");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String passwordConfirm = request.getParameter("passwordConfirm");
		List<String> errorList = new LinkedList<>(); 
		
		
		//Make sure there is an email entered
		if(username.isEmpty()) {
			errorList.add("Please enter a username.");
		} else if(userDAO.verifyUsername(username) != Integer.MIN_VALUE) {
			errorList.add("The username: " + username + " has already been registered.");
		} else {
			session.setAttribute("username", username);
		}
		
		if(email.isEmpty()) {
			errorList.add("Please enter and email address.");
		} else if(userDAO.verifyEmail(email) != Integer.MIN_VALUE) {
			errorList.add("The email: " + email + " has already been registered.");
		} else {
			session.setAttribute("email", email);
		}
		
		if(password.isEmpty()) {
			errorList.add("Password cannot be blank.");
		} else if(password.length() < 8) {
			errorList.add("Password must be longer than 8 characters.");
		} else if(!password.equals(passwordConfirm)) {
			errorList.add("Passwords do not match.");
		}
		
		if(errorList.isEmpty()) {
			if(userDAO.registerUser(username, email, password, "1")) {
				int id = userDAO.verifyUsername(username);
				User user = userDAO.getUserForID(id);
				
				session.removeAttribute("email");
				session.removeAttribute("username");
				
				session.setAttribute("userObject", user);
				session.setAttribute("loggedIn", true);
				response.sendRedirect("/dashboard");
			} else {
				response.sendRedirect("/");
			}
			
		} else {
			session.setAttribute("errorList", errorList);
			response.sendRedirect("register");
		}
		
	}
}
