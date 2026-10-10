<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Reset Password</title>
    <%@include file="all_component/allCss.jsp" %>
    <style type="text/css">
        .reset-password-img {
            background: url("img/kb.jpg");
            height: 85vh;
            width: 100%;
            background-repeat: no-repeat;
            background-size: cover;
        }
    </style>
    
</head>
<body>
<%@include file="all_component/navbar.jsp" %>
<script>
    function fetchSecurityQuestion() {
        var email = document.getElementById("exampleInputEmail1").value;
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "fetch_security_question", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xhr.onreadystatechange = function () {
            if (xhr.readyState === 4 && xhr.status === 200) {
                var securityQuestion = xhr.responseText;
                document.getElementById("qns").value = securityQuestion;
            }
        };
        xhr.send("email=" + email);
    }
    document.getElementById("exampleInputEmail1").addEventListener("change", fsq); 
    </script>
<div class="reset-password-img">
    <div class="row pt-4">
        <div class="col-md-4 offset-md-4">
            <div>
                <div class="card" style="border:solid; border-radius:1px">
                    <div class="card-body">
                        <h5 class="text-center">Reset Password</h5>

                        <c:if test="${not empty failedMsg }">
                            <h5 class="text-center text-danger">${failedMsg}</h5>
                            <c:remove var="failedMsg" scope="session" />
                        </c:if>

                        <form action="resetpasswd" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label" id="fo" >Email address</label>
                                <input type="email" class="form-control" id="email" placeholder="Enter your registered email"
                                       aria-describedby="emailHelp" required="required" name="email" >
                            </div>

                            
                            <div class="mb-3">
                                <label for="securityQuestion" class="form-label" id="fo">Security Question</label>
                                <select class="form-control" id="securityQuestion1" name="question"style="border:solid; border-radius:1px"
											name="securityQuestion1" required
											onchange="fetchSecurityQuestion()">
												<option value="">Select Security Question</option>
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
                            
                            <div class="mb-3">
                            	<input type="text" class="form-control" id="box" placeholder="Enter your answer" 
                                   aria-describedby="answer" required="required" name="answer">
                        	</div>


                            <div class="mb-3">
                                <label for="newPassword" class="form-label" id="fo">New Password</label>
                                <input type="password" class="form-control" id="box" placeholder="Enter new password"
                                       aria-describedby="newPassword" required="required" name="new_password">
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary" id="click">Reset Password</button>
                                <br> <a href="login.jsp">Back to Login</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="all_component/footer.jsp" %>
</body>
</html>
