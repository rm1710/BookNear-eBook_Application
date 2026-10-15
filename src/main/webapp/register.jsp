<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Page</title>
<%@include file="all_component/allCss.jsp"%>

<style>
.reg-img {
	background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
		url("img/ebook1.jpg");
	min-height: 150vh;
	background-size: cover;
	background-position: center;
	padding-top: 40px;
}

.register-card {
	background: #ffffff;
	border-radius: 10px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
	padding: 25px;
}

.form-control:focus {
	box-shadow: none;
	border-color: #0d6efd;
}

.error-text {
	color: red;
	font-size: 13px;
}
</style>
</head>

<body>

	<%@include file="all_component/navbar.jsp"%>

	<div class="reg-img">
		<div class="container">
			<div class="row justify-content-center">
				<div class="col-md-5">

					<div class="card register-card">
						<div class="card-body">

							<h3 class="text-center mb-4">Create Account</h3>

							<!-- Messages -->
							<c:if test="${not empty succMsg}">
								<div class="alert alert-success text-center">${succMsg}</div>
								<c:remove var="succMsg" scope="session" />
							</c:if>

							<c:if test="${not empty failedMsg}">
								<div class="alert alert-danger text-center">${failedMsg}</div>
								<c:remove var="failedMsg" scope="session" />
							</c:if>

							<form action="register" method="post"
								onsubmit="return validateForm()">

								<!-- Full Name -->
								<div class="mb-3">
									<label class="form-label">Full Name</label> <input type="text"
										class="form-control" id="fname" name="fname"
										placeholder="Enter your full name" required> <small
										id="nameError" class="error-text"></small>
								</div>

								<!-- Email -->
								<div class="mb-3">
									<label class="form-label">Email</label> <input type="email"
										class="form-control" id="email" name="email"
										placeholder="Enter email" required> <small
										id="emailError" class="error-text"></small>
								</div>

								<!-- Mobile -->
								<div class="mb-3">
									<label class="form-label">Mobile Number</label> <input
										type="tel" class="form-control" id="phno" name="phno"
										placeholder="10 digit mobile number"
										oninput="limitDigits(this,10)" required> <small
										id="phoneError" class="error-text"></small>
								</div>

								<!-- Security Question -->
								<div class="mb-3">
									<label class="form-label">Security Question</label> <select
										class="form-control" id="question" name="question"
										onchange="toggleAnswerInput()" required>
										<option value="">Select Security Question</option>
										<option>What is your pet's name?</option>
										<option>What is your mother's maiden name?</option>
										<option>What city were you born in?</option>
										<option>What is your favorite movie?</option>
										<option>What is your favorite food?</option>
										<option>What is your favorite place?</option>
										<option>What is your childhood nickname?</option>
										<option>What is the name of the street you grew up
											on?</option>

									</select> <small id="questionError" class="error-text"></small>
								</div>

								<!-- Answer -->
								<div class="mb-3 d-none" id="answerBox">
									<label class="form-label">Answer</label> <input type="text"
										class="form-control" id="answer" name="answer"
										placeholder="Enter your answer" required>
								</div>

								<!-- Password -->
								<div class="mb-3">
									<label class="form-label">Password</label> <input
										type="password" class="form-control" id="password"
										name="password" placeholder="Strong password"
										oninput="validatePassword(this)" required> <small
										id="passwordError" class="error-text"></small>
								</div>

								<!-- Terms -->
								<div class="mb-3 form-check">
									<input type="checkbox" class="form-check-input" id="check"
										name="check"> <label class="form-check-label">
										I agree to Terms & Conditions </label> <small id="checkError"
										class="error-text"></small>
								</div>
								<div class="row mt-3 g-2">

									<div class="col-12 col-md-6">
										<button type="reset"
											class="btn btn-outline-secondary w-100 fw-bold py-2">
											Reset</button>
									</div>

									<div class="col-12 col-md-6">
										<button type="submit"
											class="btn btn-primary w-100 fw-bold py-2">Register
										</button>
									</div>

								</div>

							</form>

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<%@include file="all_component/footer.jsp"%>

	<script>
		function limitDigits(input, maxLength) {
			input.value = input.value.replace(/\D/g, '');
			if (input.value.length > maxLength) {
				input.value = input.value.slice(0, maxLength);
			}
		}

		function validatePassword(input) {
			let pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
			if (!pattern.test(input.value)) {
				document.getElementById("passwordError").innerText = "Min 8 chars, include uppercase, lowercase, number & special char";
			} else {
				document.getElementById("passwordError").innerText = "";
			}
		}

		function toggleAnswerInput() {
			let question = document.getElementById("question").value;
			let answerBox = document.getElementById("answerBox");

			if (question === "") {
				answerBox.classList.add("d-none");
			} else {
				answerBox.classList.remove("d-none");
			}
		}

		function validateForm() {

			let valid = true;

			let phone = document.getElementById("phno").value;
			if (!/^\d{10}$/.test(phone)) {
				document.getElementById("phoneError").innerText = "Mobile number must be 10 digits";
				valid = false;
			} else {
				document.getElementById("phoneError").innerText = "";
			}

			let question = document.getElementById("question").value;
			if (question === "") {
				document.getElementById("questionError").innerText = "Please select security question";
				valid = false;
			} else {
				document.getElementById("questionError").innerText = "";
			}

			let check = document.getElementById("check").checked;
			if (!check) {
				document.getElementById("checkError").innerText = "You must agree to terms";
				valid = false;
			} else {
				document.getElementById("checkError").innerText = "";
			}

			return valid;
		}
	</script>

</body>
</html>
