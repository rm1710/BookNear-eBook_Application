<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Books</title>
<%@include file="allcss.jsp"%>
</head>
<body style="background:#e3f2fd">
	<%@include file="navbar.jsp"%>
	<c:if test="${empty userobj }">
		<c:redirect url="../login.jsp"/>
	</c:if>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4 p-3">
			<div class="card">
				<div class="card-body">
				<h4 class="text-center">Add Book</h4>
				
				
				<c:if test="${not empty succMsg }">
					<p class="text-center text-success">${succMsg }</p>
					<c:remove var="succMsg" scope="session"/>
				</c:if>
				
				
				<c:if test="${not empty failedMsg }">
					<p class="text-center text-danger">${failedMsg }</p>
					<c:remove var="failedMsg" scope="session"/>
				</c:if>
				
				
					<form action="../add_books" method="post" enctype="multipart/form-data">
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
							<option >Programming</option>
							<option >Anime</option>
							<option >Story</option>
							<option >Novel</option>
							<option >Science Fiction</option>
							<option >Fantasy</option>
							<option >Romance</option>
							<option >fiction</option>
							<option >Drama</option>
							<option >Horror</option>
							<option >Biography</option>
							<option >Autobiography</option>
							</select>
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">category*</label>
							<select id="inputState" name="category" class="form-control">
							<option selected>--select-- </option>
							<option value="new">New Book</option>
							<option value="old">Old Book</option>
							</select>
						</div>
						
						<div class="form-group">
							<label for="exampleInputEmail1">Book Status*</label>
							<select id="inputState" name="status" class="form-control">
							<option selected>--select-- </option>
							<option value="active">Active</option>
							<option value="inactive">Inactive</option>
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
	<div style="margin-top:40px;"><%@include file="footer.jsp" %></div>
</body>
</html>