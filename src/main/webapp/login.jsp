<%@page import="ekart.entity.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	User user= (User)session.getAttribute("currentuser");
	if(user != null) {
		if(user.getUserType().equals("admin")) {
			response.sendRedirect("adminProfile.jsp");
		}else {
			response.sendRedirect("profile.jsp");
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Login || Ekart</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<%@include file="component/coomon_css_js.jsp"%>
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<%@include file="component/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-4">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body">
						<h5 class="text-center">Login Here</h5>
						<%@include file="component/message.jsp"%>
						<form action="LoginServlet" method="post">
							<div class="mb-3">
								<label for="exampleInputEmail1" class="form-label">Email
									address</label> <input type="email" name="uemail" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp">
								<div id="emailHelp" class="form-text">We'll never share
									your email with anyone else.</div>
							</div>
							<div class="mb-3">
								<label for="exampleInputPassword1" class="form-label">Password</label>
								<input type="password" name="upass" class="form-control"
									id="exampleInputPassword1">
							</div>
							<div class="mb-3 form-check">
								<input type="checkbox" onclick="myFunction()"
									class="form-check-input" id="exampleCheck1"> <label
									class="form-check-label" for="exampleCheck1">Show
									Password</label>
							</div>
							<div class="d-grid gap-2">
								<button class="btn btn-primary" type="submit">Submit</button>
							</div>
						</form>

						<div class="text-center mt-2">
							<a href="Register.jsp" style="text-decoration: none;">Create
								New Account</a>
						</div>

					</div>
				</div>
			</div>
		</div>

	</div>
	<script>
		function myFunction() {
			var x = document.getElementById("exampleInputPassword1");
			if (x.type === "password") {
				x.type = "text";
			} else {
				x.type = "password";
			}
		}
	</script>
</body>
</html>