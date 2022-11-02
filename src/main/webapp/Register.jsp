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
<title>Ekart || Signin</title>
<%@include file="component/coomon_css_js.jsp"%>
</head>
<body>
	<%@include file="component/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-4">
			<div class="col-md-4 offset-md-4">
				<div class="card">
					<div class="card-body px-5">
					
						<div class="text-center">
							<span class=" fa fa-user-circle  fa-3x"></span>
							<h4 class="my-3">SignUp Here</h4>
						</div>
						<form action="RegisterServlet" method="post" id="form-reg">
							<div class="form-group">
								<label for="username" class="form-label">User Name</label> <input
									type="text" class="form-control" id="username" name="username"
									aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="useremail" class="form-label">Email</label> <input
									type="email" class="form-control" id="useremail"
									name="useremail" aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="userpass" class="form-label">Password</label> <input
									type="password" class="form-control" id="userpass"
									name="userpass" aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="userphone" class="form-label">Phone</label> <input
									type="number" class="form-control" id="userphone"
									name="userphone" aria-describedby="emailHelp">
							</div>
							<div class="form-group">
								<label for="userAdd" class="form-label">Address</label>
								<textarea name="userAdd" style="height: 100px;" id="userAdd"
									class="form-control"></textarea>
							</div>

							<div class="container text-center" id="loader" style="display: none;">
                                    <span class="fas fa-sync-alt fa-spin fa-3x"></span>
                                    <h4>Please Wait ...</h4>
                                </div>
							<div class="container text-center mt-3" id="submit-btn">
								<button type="submit" class="btn btn-outline-success">Submit</button>
								<button type="reset" class="btn btn-outline-warning">Reset</button>
							</div>
						</form>
						<p class="mt-2 text-center">Already Register <a href="login.jsp" style="text-decoration: none;">Login here</a></p>
					</div>

				</div>
			</div>
		</div>
	</div>
	<script>
            $(document).ready(function() {
                
                $('#form-reg').on('submit',function (event){
                    event.preventDefault();
                    
                    let form = new FormData(this);
                    $("#submit-btn").hide();
                    $("#loader").show();
                    $.ajax({
                       url: "RegisterServlet",
                       type: 'POST',
                       data: form,
                       success: function (data, textStatus, jqXHR) {
                           
                         $("#submit-btn").show();
                         $("#loader").hide();
                         if (data.trim() === 'done') {
                              swal("Registerd Successfully, Redirect to Login Page")
                            .then((value) => {
                                window.location="login.jsp"
                            });
                         } else if(data.trim() === 'error') {
                        	 
                             swal("Please check your entry");
                         }else {
                             swal(data);
                         }
                         
                         
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                         $("#submit-btn").show();
                         $("#loader").hide();
                         swal("Something went wrong");
                             
                        
                    },
                    processData: false,
                    contentType: false 
                       
                    });
                    
                });
    
            });
        </script>
</body>
</html>