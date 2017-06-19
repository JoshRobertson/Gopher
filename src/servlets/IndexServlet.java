package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -3792047100550048731L;
	
	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response){
		//NO POST ACTIONs
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response){
		try {
			request.getRequestDispatcher("WEB-INF/index.jsp").forward(request, response);
		} catch (ServletException | IOException e) {
			e.printStackTrace();
		}
	}
}
