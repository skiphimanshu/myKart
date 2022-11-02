<%@page import="ekart.helper.FactoryProvider"%>
<%@page import="ekart.entity.User"%>
<%@page import="ekart.entity.Category"%>
<%@page import="ekart.dao.CategoryDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User user = (User) session.getAttribute("currentuser");
if (user == null) {
	session.setAttribute("msg", "You are not logged in");
	response.sendRedirect("login.jsp");
	return;

} else {
	if (user.getUserType().equals("normal")) {
		session.removeAttribute("currentuser");
		session.setAttribute("msg", "you are not admin !");
		response.sendRedirect("login.jsp");
		return;
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Hello Admin</title>
<%@include file="component/coomon_css_js.jsp"%>
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<%@include file="component/navbar.jsp"%>

	<div class="container admin">
		<div class="container-fluid">
			<%@include file="component/message.jsp" %>
		</div>
		<!-- First Row -->
		<div class="row mt-3">
			<div class="col-md-4 text-center">
				<!-- fisrt col -->
				<div class="card ">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 90px;" class="img-fluid" alt="user_icon"
								src="img/man.png">
						</div>
						<h1>4555</h1>
						<h1>Users</h1>
					</div>
				</div>

			</div>
			<div class="col-md-4  text-center">
				<!-- second col -->
				<div class="card">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 90px;" class="img-fluid" alt="user_icon"
								src="img/options.png">
						</div>
						<h1>254</h1>
						<h1>Category</h1>
					</div>
				</div>

			</div>
			<div class="col-md-4  text-center">
				<!-- third col -->
				<div class="card">
					<div class="card-body">
						<div class="container">
							<img style="max-width: 90px;" class="img-fluid" alt="user_icon"
								src="img/package.png">
						</div>
						<h1>78945</h1>
						<h1>Products</h1>
					</div>
				</div>

			</div>
		</div>

		<!-- Second Row -->
		<div class="row mt-3">
			<!-- Fisrt Column -->
			<div class="col-md-6 text-center">
				<div class="card" data-bs-toggle="modal"
					data-bs-target="#addCategory">
					<div class="card-body">
						<img style="max-width: 90px;" class="img-fluid" alt="user_icon"
							src="img/menu.png">
						<p class="mt-2">Click here to add new Product</p>
						<h1>Add Category</h1>
					</div>
				</div>
			</div>

			<div class="col-md-6 text-center">
				<!-- Second Column -->
				<div class="card" data-bs-toggle="modal"
					data-bs-target="#addProduct">
					<div class="card-body">
						<img style="max-width: 90px;" class="img-fluid" alt="user_icon"
							src="img/add-to-basket.png">
						<p class="mt-2">Click here to add new Product</p>
						<h1>Add Products</h1>
					</div>
				</div>
			</div>

		</div>
	</div>
	
	
	<!-- Add Category modal -->
	<div class="modal fade" id="addCategory" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">Add Category</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationServlet" method="post" id="form-addCat">
						<input type="hidden" name="operation" value="addCategory">
						<div class="form-group">
							<input type="text" class="form-control" name="cTitle"
								placeholder="Enter category title">
						</div>
						<br>
						<div class="form-group">
							<textarea style="height: 150px;" class="form-control"
								name="cDesc" placeholder="Enter category description"></textarea>
						</div>
						<br>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End of Add Category modal -->
	
	<!-- Add product Modal -->
		
	<div class="modal fade" id="addProduct" data-bs-backdrop="static"
		data-bs-keyboard="false" tabindex="-1"
		aria-labelledby="staticBackdropLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="staticBackdropLabel">Add Product</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationServlet" method="post" id="form-addCat" enctype="multipart/form-data">
						<input type="hidden" name="operation" value="addProduct">
						<div class="form-group">
							<input type="text" class="form-control" name="pName"
								placeholder="Enter product title">
						</div>
						<br>
						<div class="form-group">
							<textarea style="height: 150px;" class="form-control"
								name="pDesc" placeholder="Enter Product description"></textarea>
						</div>
						<br>
						<div class="form-group">
							<input type="number" class="form-control" name="pPrice"
								placeholder="Enter Product Price">
						</div>
						<br>
						<div class="form-group">
							<input type="number" class="form-control" name="pDis"
								placeholder="Enter Product discount">
						</div>
						<br>
						<div class="form-group">
							<input type="text" class="form-control" name="pQunt"
								placeholder="Enter product Quantity">
						</div>
						<br>
						<%
							CategoryDao catDao = new CategoryDao(FactoryProvider.getFactory());
							List<Category> catList = catDao.getAllCategory();
						%>
						
						
						
						
						<div class="form-group">
							<select name="catId" class="form-control" id="">
								<option selected disabled>Select product category</option>
								<%
									for(Category c:catList){
								%>
								<option value="<%= c.getCatId() %>"><%=c.getcTitle() %></option>
								<%} %>
							</select>
						</div>
						<br>
						<div class="form-group">
							<input type="file" class="form-control" name="pPic"
								placeholder="Select Product Image" required>
						</div>
						<br>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Product</button>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End of ADD Product modal
	 -->
</body>
</html>