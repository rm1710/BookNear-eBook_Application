<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Setting</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">
a{
text-decoration:none;
color:black;
}
a:hover{
	text-decoration:none;
}
/* styles.css */

body {
    background-color: #e0f7fa;
}

.card {
    transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out, opacity 0.3s ease-in-out;
    transform-style: preserve-3d;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Add your desired shadow values */
    opacity: 1;
}

.card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Add your desired shadow values for hover */
}

.fade-in {
    animation: fadeIn 0.8s ease-out; /* Adjust duration and easing as needed */
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

</style>
</head>
<body style="background-color: #fff3e0;">
<c:if test="${empty userobj }">
<c:redirect url="login.jsp"/>
</c:if>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container">

	<h3 class="text-center">Welcome,${userobj.name }</h3>
		
		
		<div class="row p-5">
			<div class="col-md-4">
				<a href="sell_book.jsp">
					<div class="card">
						<div class="card-body" align="center">
							<div class="text-primary">
								<img src="img/b.png" height="130px" width="150px">
							</div>
							<h3>Sell Old Book</h3>
						</div>
					</div>
				</a>
			</div>
			
			<div class="col-md-4">
				<a href="old_book.jsp">
					<div class="card">
						<div class="card-body" align="center">
							<div class="text-primary">
								<img src="img/books3D.jpg" height="100px" width="120px">
							</div>
							<h3>Old Book</h3>
							<h5>(Added Books Data)</h5>
						</div>
					</div>
				</a>
			</div>
			
			<div class="col-md-4">
				<a href="Edit_profile.jsp">
					<div class="card">
						<div class="card-body" align="center">
							<div class="text-dark">
								<img src="img/user.png" height="96px" width="110px">
							</div>
							<h3>Login & security </h3>
							<h5>(Edit Profile)</h5>
						</div>
					</div>
				</a>
			</div>
			
			<div class="col-md-6 mt-4">
				<a href="order.jsp">
					<div class="card">
						<div class="card-body text-center" align="center">
							<div class="text-dark">
								<img src="img/box.png" height="110px" width="120px">
							</div>
							<h3>My Order</h3>
							<h5>(Track Your Order)</h5>
						</div>
					</div>
				</a>
			</div>
			
			<div class="col-md-6 mt-4">
				<a href="helpline.jsp">
					<div class="card">
						<div class="card-body text-center" align="center">
							<div class="text-dark">
								<img src="img/phone.jpg" height="110px" width="120px">
							</div>
							<h3>Help Center</h3>
							<h5>(24*7 Service)</h5>
						</div>
					</div>
				</a>
			</div>
			
		</div>
	</div>
	<div class="mt-2"><%@include file="all_component/footer.jsp"%></div>
</body>
</html>