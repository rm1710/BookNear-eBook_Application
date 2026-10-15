<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login page</title>
<%@include file="all_component/allCss.jsp"%>
<style>
.log-img {
	background: url("img/ebook3.jpg");
	height: 120vh;
	width: 100%;
	background-repeat: no-repeat;
	background-size: cover;
}

.login-card {
	background-color: rgba(255, 255, 255, 0.9);
	border: 2px solid #ddd;
	border-radius: 5px;
	padding: 20px;
}

.error-text {
	color: red;
	font-size: 14px;
}
</style>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	<div class="log-img">
		<div class="row pt-4">
			<div class="col-md-4 offset-md-4">
				<div class="card login-card">
					<div class="card-body">

						<div class="text-center">
							<i class="fa-solid fa-user fa-3x mb-2"></i>
							<h3>Login</h3>
						</div>

						<c:if test="${not empty failedMsg}">
							<div class="alert alert-danger text-center">${failedMsg}</div>
							<c:remove var="failedMsg" scope="session" />
						</c:if>

						<c:if test="${not empty succMsg}">
							<div class="alert alert-success text-center">${succMsg}</div>
							<c:remove var="succMsg" scope="session" />
						</c:if>

						<!-- Login Form -->
						<form action="login" method="post"
							onsubmit="return validateForm()">

							<!-- Email -->
							<div class="mb-3">
								<label class="form-label">Email Address</label> <input
									type="email" class="form-control" id="email" name="email"
									placeholder="Enter Email" value="${param.email}" required>
								<small id="emailError" class="error-text"></small>
							</div>

							<!-- Password -->
							<div class="mb-3">
								<label class="form-label">Password</label> <input
									type="password" class="form-control" id="password"
									name="password" placeholder="Enter Password" required>
								<small id="passwordError" class="error-text"></small>
							</div>

							<!-- Submit -->
							<div class="text-center">
								<button type="submit" class="btn btn-primary w-100">
									Login</button>
								<br>
								<br> <a href="forgetpasswd.jsp">Forgot Password?</a> <br>
								<a href="register.jsp">Create Account</a>
							</div>

						</form>

					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="all_component/footer.jsp"%>
	<script>
		function validateForm() {

			let email = document.getElementById("email").value.trim();
			let password = document.getElementById("password").value.trim();

			let emailError = document.getElementById("emailError");
			let passwordError = document.getElementById("passwordError");

			emailError.innerHTML = "";
			passwordError.innerHTML = "";

			let valid = true;

			let emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/;

			if (!email.match(emailPattern)) {
				emailError.innerHTML = "Please enter a valid email address";
				valid = false;
			}

			if (password.length < 6) {
				passwordError.innerHTML = "Password must be at least 6 characters";
				valid = false;
			}

			return valid;
		}
	</script>
</body>
</html>