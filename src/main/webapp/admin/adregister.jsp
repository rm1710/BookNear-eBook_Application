<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Admin Registration page</title>
        <%@include file="allcss.jsp" %>
        <style type="text/css">
            .reg-img {
                height: 120vh;
                width: 100%;
                background-repeat: no-repeat;
                background-size: cover;
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="reg-img">
            <div class="container pt-3">
                <div class="row">
                    <div class="col-md-4 offset-md-4">
                        <div class="card" style="border-radius:1px; border:solid 2px">
                            <div class="card-body">
                                <h4 class="text-center">Registration Page</h4>

                                <c:if test="${not empty succMsg }">
                                    <p class="text-center text-success">${succMsg}</p>
                                    <c:remove var="succMsg" scope="session"/>
                                </c:if>
                                <c:if test="${not empty failedMsg }">
                                    <p class="text-center text-danger">${failedMsg}</p>
                                    <c:remove var="failedMsg" scope="session"/>
                                </c:if>

                                <form action="../adRegis" method="post">

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label" id="fo" >Enter Full Name</label> 
                                        <input type="text" class="form-control" id="box" aria-describedby="emailHelp" placeholder="Enter Name"required="required" name="fname">
                                    </div>

                                    <div class="mb-3">
                                        <label for="exampleInputEmail1" class="form-label" id="fo" >Email</label> 
                                        <input type="email" class="form-control" id="box" aria-describedby="emailHelp" placeholder="Enter Email"required="required" name="email">
                                    </div>

									<div class="mb-3">
                                        <label for="exampleInputPassword1" class="form-label" id="fo" >password</label>
                                        <input type="password" class="form-control" id="box" placeholder="Enter Password" required="required" name="password">
                                    </div>

                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" id="exampleCheck1" name="check"> 
                                        <label class="form-check-label" for="exampleCheck1" id="fo" >Agree terms & condition</label>
                                    </div>
                                    <div class="text-center">
                                    <button type="submit" class="btn btn-primary" id="click">Register</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
       <div style="margin-top:-5px"><%@include file="footer.jsp"%></div>
    </body>
</html>