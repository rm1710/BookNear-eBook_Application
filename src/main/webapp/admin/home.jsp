<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin:home</title>
<%@include file="allcss.jsp"%>
<style type="text/css">
a{
text-decoration:none;
color:black;
}

a:hover{
text-decoration:none;
color:black;
}
/* styles.css */

body {
    background-color: #e0f7fa;
    font-family: 'Arial', sans-serif;
}

.container {
    margin-top: 40px;
}

.card {
    transition: transform 0.3s ease-in-out;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

.card:hover {
    transform: scale(1.20);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.card-body {
    padding: 20px;
}

.text-center {
    text-align: center;
}

.form-group {
    margin-bottom: 20px;
}

label {
    font-weight: bold;
}

.btn-primary {
    background-color: #007bff;
    color: #fff;
    border: none;
}

.btn-primary:hover {
    background-color: #0056b3;
}

/* Style for file input */
.form-control-file {
    display: block;
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    margin-bottom: 5px;
    border: 1px solid #ced4da;
    border-radius: 4px;
}

/* Additional styling for the footer */
.footer {
    background-color: #37474f;
    color: #fff;
    text-align: center;
    padding: 10px;
    position: fixed;
    bottom: 0;
    width: 100%;
}

</style>
</head>
<body style="background-color:#e0f7fa">
	<%@include file="navbar.jsp"%>
	<c:if test="${empty userobj }">
		<c:redirect url="../login.jsp"/>
	</c:if>
	<div class="container">
		<div class="row p-5">
		
			<div class="col-md-3">
				<a href="add_books.jsp">
					<div class="card">
						<div class="card-body text-center">
							<i class="fa-solid fa-plus fa-3x text-success"></i><br>
							<h4>Add book</h4>
						</div>
					</div>
				</a>
			</div>


			<div class="col-md-3">
				<a href="all_books.jsp">
					<div class="card">
						<div class="card-body text-center">
							<i class="fa-solid fa-book-open fa-3x text-info"></i><br>
							<h4>Added book</h4>
						</div>
					</div>
				</a>
			</div>


			<div class="col-md-3">
				<a href="orders.jsp">
					<div class="card">
						<div class="card-body text-center">
							<i class="fa-solid fa-box-open fa-3x text-warning"></i><br>
							<h4>order</h4>
						</div>
					</div>
				</a>
			</div>


			<div class="col-md-3">
			<a href="login.jsp" data-toggle="modal" data-target="#exampleModal">
				<div class="card">
					<div class="card-body text-center">
						<i class="fa-solid fa-right-from-bracket fa-3x text-primary"></i><br>
						<h4>Logout</h4>
					</div>
				</div>
				</a>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center">
        	<h4>Do you want logout? </h4>
         	<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         	<a href="../logout"type="button" class="btn btn-primary text-white">Logout</a>
        </div>
      </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>
</div>
	
	<div style="margin-top:180px;"><%@include file="footer.jsp" %></div>
</body>
</html>