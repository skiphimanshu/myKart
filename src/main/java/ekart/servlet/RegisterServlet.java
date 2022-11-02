package ekart.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;
import org.hibernate.Transaction;

import ekart.entity.User;
import ekart.helper.FactoryProvider;

@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter pw  = response.getWriter();
		try {
			
			
			String uname = request.getParameter("username");
			String uemail = request.getParameter("useremail");
			String upass = request.getParameter("userpass");
			String uphone = request.getParameter("userphone");
			String uaddress = request.getParameter("userAdd");
			
			User user = new User(uname,uemail,upass,uphone,"default.png",uaddress,"normal");
			Session hSession = FactoryProvider.getFactory().openSession();
			Transaction tx =  hSession.beginTransaction();
			int userId = (Integer) hSession.save(user);
			tx.commit();
			hSession.close();
			if(userId >0 ) {
				pw.println("done");
			}
			
		}catch (Exception e) {
			pw.println("error");
		}
		
		
	}

}
