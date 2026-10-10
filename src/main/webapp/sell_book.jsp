<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #fce4ec;">
<c:if test="${empty userobj }">
<c:redirect url="login.jsp" />
</c:if>
<%@include file="all_component/navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4">
				<div class="card mt-4">
					<div class="card-body">
						<h4 class="text-center">Sell Old Book</h4>
						
						
						<c:if test="${not empty succMsg }">
							<h4 class="text-center text-success">${succMsg }</h4>
							<c:remove var="succMsg" scope="session" />
						</c:if>


						<c:if test="${not empty failedMsg }">
							<h4 class="text-center text-danger">${failedMsg }</h4>
							<c:remove var="failedMsg" scope="session" />
						</c:if>
						
						
						<form action="add_old_book" method="post" enctype="multipart/form-data">
						<input type="hidden" value="${userobj.email }" name="user">
							<div class="form-group">
								<label for="exampleInputEmail1">Book Name*</label>
								<input type="text" class="form-control" id="exampleInputEmail1" area-describedly="emailHelp" name="bname">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Author Name*</label>
								<input type="text" class="form-control" id="exampleInputEmail1" area-describedly="emailHelp" name="author">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Price*</label>
								<input type="number" class="form-control" id="exampleInputEmail1" area-describedly="emailHelp" name="price">
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Book Category*</label>
								<select id="inputState" name="bookcategory" class="form-control">
								<option selected>--select-- </option>
								<option >Mythology</option>
								<option >programming</option>
								<option >story</option>
								<option >novel</option>
								<option >Science Fiction</option>
								<option >fantasy</option>
								<option >Horror</option>
								<option >Biography</option>
								<option >Autobiography</option>
								</select>
							</div>
							<div class="form-group">
								<label for="exampleInputEmail1">Upload Photo*</label>
								<input name="bimg" type="file" class="form-control-file" id="exampleInputEmail1" area-describedly="emailHelp">
							</div>
							<button type="submit" class="btn btn-primary">Add</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="mt-4"><%@include file="all_component/footer.jsp"%></div>
</body>
</html>