<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="all_component/allCss.jsp"%>
<script>
function toggleAnswerInput(questionNumber) {
    var selectedQuestion = document.getElementById("securityQuestion" + questionNumber).value;
    var answerInput = document.getElementById("answer" + questionNumber);
    if (selectedQuestion !== "") {
        answerInput.style.display = "block";
    } else {
        answerInput.style.display = "none";
    }
}

</script>
</head>
<body style="background-color: #f3e5f5;">
<%@include file="all_component/navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card mt-4" style="border:solid; border-radius:1px">
					<div class="card-body">
					<h4 class="text-center">Edit Profile</h4>
					
						<c:if test="${not empty failedMsg }">
							<h5 class="text-center text-danger">${failedMsg}</h5>
							<c:remove var="failedMsg" scope="session" />
						</c:if>

						<c:if test="${not empty succMsg }">
							<h5 class="text-center text-success">${succMsg}</h5>
							<c:remove var="succMsg" scope="session" />
						</c:if>
						<form action="update_profile" method="post">
							  <input type="hidden" value="${userobj.id }" name="id">
                              <div class="mb-3">
                                  <label for="exampleInputEmail1" id="fo" class="form-label">Enter Full Name</label> 
                                  <input type="text" class="form-control" id="box" aria-describedby="emailHelp" required="required" name="fname" value="${userobj.name }">
                              </div>

                              <div class="mb-3">
                                  <label for="exampleInputEmail1" class="form-label" id="fo" >Email address</label> 
                                  <input type="email" class="form-control" id="box" aria-describedby="emailHelp" required="required" name="email" value="${userobj.email }">
                              </div>

                              <div class="mb-3">
                                  <label for="exampleInputEmail1" id="fo" class="form-label">Mobile No.</label> 
                                  <input type="tel" class="form-control" id="box" aria-describedby="emailHelp" required="required" name="phno" value="${userobj.phno }">
                              </div>
                              
                              <div class="mb-3">
										<label for="securityQuestion1" class="form-label" id="fo">Security
											Question</label> 
										<select class="form-control" id="securityQuestion1" name="question" style="border:solid; border-radius:1px"
											name="securityQuestion1" required
											onchange="toggleAnswerInput(1)">
											 	<option value="">Select New Security Question</option>
											    <option value="What is your pet's name?">What is your pet's name?</option>
											    <option value="What is your mother's maiden name?">What is your mother's maiden name?</option>
											    <option value="What city were you born in?">What city were you born in?</option>
											    <option value="What is the name of your favorite teacher?">What is the name of your favorite teacher?</option>
											    <option value="What was your childhood nickname?">What was your childhood nickname?</option>
											    <option value="What is the name of the street you grew up on?">What is the name of the street you grew up on?</option>
											    <option value="What is your favorite movie?">What is your favorite movie?</option>
											    <option value="What is your favorite food?">What is your favorite food?</option>
											    <option value="What is the name of your best friend in high school?">What is the name of your best friend in high school?</option>
											    <option value="What is your favorite color?">What is your favorite color?</option>
										</select>
									</div>

									<div class="mb-3 answer-input" id="answer1">
										<input type="text" class="form-control" id="box"
											placeholder="Enter Answer" required="required" name="answer">
									</div>

                              <div class="mb-3">
                                  <label for="exampleInputPassword1" id="fo" class="form-label">password</label>
                                  <input type="password" class="form-control" id="box" placeholder="Enter Password" required="required" name="password">
                              </div>
                              <div class="text-center p-2">
                              <button type="submit" class="btn btn-primary  btn-sm" id="click">Update</button>
                              </div>
                          </form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="mt-4"><%@include file="all_component/footer.jsp"%></div>
</body>
</html>