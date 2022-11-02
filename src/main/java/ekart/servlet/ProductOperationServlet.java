package ekart.servlet;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import ekart.dao.CategoryDao;
import ekart.dao.ProductDao;
import ekart.entity.Category;
import ekart.entity.Product;
import ekart.helper.FactoryProvider;

@MultipartConfig
public class ProductOperationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 response.setContentType("text/html");
		 PrintWriter pw = response.getWriter();
		 try {
			 String op = request.getParameter("operation");
			 if(op.trim().equals("addCategory")) {
				 //add Category
				 
					String cTitle = request.getParameter("cTitle");
					String cDesc = request.getParameter("cDesc");
					Category category = new Category();
					category.setcTitle(cTitle);
					category.setcDesc(cDesc);
					CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
					int catId = categoryDao.saveCategory(category);
					HttpSession httpSession = request.getSession();
					httpSession.setAttribute("m1", "Category Added Successfully");
					response.sendRedirect("adminProfile.jsp");
					return;
				 
				 
			 }else if(op.trim().equals("addProduct")) {
				 //add Product
				 
				 String pName = request.getParameter("pName");
				 String pDesc = request.getParameter("pDesc");
				 int pPrice = Integer.parseInt(request.getParameter("pPrice"));
				 int pDis = Integer.parseInt(request.getParameter("pDis"));
				 int pQuant = Integer.parseInt(request.getParameter("pQunt"));
				 int pCatId = Integer.parseInt(request.getParameter("catId"));
				 Part part = request.getPart("pPic");
				
				 Product product = new Product();
				 product.setPName(pName);
				 product.setpDesc(pDesc);
				 product.setpPrice(pPrice);
				 product.setpDiscount(pDis);
				 product.setpQuantity(pQuant);
				 product.setpPhoto(part.getSubmittedFileName());
				 
				 CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
				 Category cat =  catDao.getCategoryById(pCatId);
				 
				 product.setCategory(cat);
				 
				 ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
				 pDao.saveProduct(product);
				 
				 String path = request.getRealPath("/")+"img"+File.separator+"products"+File.separator+part.getSubmittedFileName();
				 // Img uplaoding
				 FileOutputStream fos = new FileOutputStream(path);
				 InputStream is = part.getInputStream();
				 // read data
				 byte b[] = new byte[is.available()];
				 is.read(b); 	
				 
				 fos.write(b); 
				 fos.close();
				 
				 HttpSession httpSession = request.getSession();
				 httpSession.setAttribute("m1", "Product Added Successfully");
				 response.sendRedirect("adminProfile.jsp");
				 return;
			 }	
			
		} catch (Exception e) {
			pw.println(e);
			
		}
	}

}
