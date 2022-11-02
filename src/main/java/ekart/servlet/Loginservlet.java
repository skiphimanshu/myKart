package ekart.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import ekart.dao.UserDao;
import ekart.entity.User;
import ekart.helper.FactoryProvider;

public class Loginservlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		try {
			String email = request.getParameter("uemail");
			String pass = request.getParameter("upass");
			//validation
			UserDao userdao = new UserDao(FactoryProvider.getFactory());
			User user = userdao.getUserByEmailAndPassword(email, pass);
			HttpSession httpSession = request.getSession();
			
			if(user == null) {
				httpSession.setAttribute("msg", "Invaild Details");
				response.sendRedirect("login.jsp");
				
			}else {
				HttpSession session = request.getSession();
				session.setAttribute("currentuser", user);
				if(user.getUserType().equals("admin")) {
					// for Admin
					response.sendRedirect("adminProfile.jsp");
					
				}else if(user.getUserType().equals("normal")) {
					//for user
					response.sendRedirect("profile.jsp");
				}else {
					httpSession.setAttribute("msg", "Non Identify user");
					response.sendRedirect("login.jsp");
				}
					
					
			}
			
		}catch(Exception e) {
			pw.println(e);
			
		}
	}

}
