<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<%@ page import="com.DB.*" %>
<%@ page import="com.DAO.*" %>
<%@ page import="com.entity.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>edit books details</title>
<%@include file="allcss.jsp"%>
</head>
<body style="background:#e3f2fd">
	<%@include file="navbar.jsp"%>
	<div class="container">
		<div class="row">
			<div class="col-md-4 offset-md-4 p-3">
			<div class="card">
				<div class="card-body">
				<h4 class="text-center">Edit Book</h4>
				
				
				<c:if test="${not empty succMsg }">
					<p class="text-center text-success">${succMsg }</p>
					<c:remove var="succMsg" scope="session"/>
				</c:if>
				
				
				<c:if test="${not empty failedMsg }">
					<p class="text-center text-danger">${failedMsg }</p>
					<c:remove var="failedMsg" scope="session"/>
				</c:if>
				
				<%
				int id=Integer.parseInt(request.getParameter("id"));
				BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
				BookDtls b=dao.getBookById(id);
				
				
				%>
				
					<form action="../editbooks" method="post">
					<input type="hidden" name="id" value="<%=b.getBookId() %>"><br>
						<div class="form-group">
							<label for="exampleInputEmail1">Book Name*</label>
							<input type="text" class="form-control" id="exampleInputEmail1" area-describedly="emailHelp" name="bname" value="<%=b.getBookName()%>">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Author Name*</label>
							<input type="text" class="form-control" id="exampleInputEmail1" area-describedly="emailHelp" name="author" value="<%=b.getAuthor()%>">
						</div>
						<div class="form-group">
							<label for="exampleInputEmail1">Price*</label>
							<input type="number" class="form-control" id="exampleInputEmail1" area-describedly="emailHelp" name="price" value="<%=b.getPrice()%>">
						</div>
						
						<div class="form-group">
							<label for="exampleInputEmail1">Book Status*</label>
							<select id="inputState" name="status" class="form-control">
							
							<%if("Active".equals(b.getStatus())){ %>
								<option value="active">inactive</option>
								<option value="inactive">Active</option>
							<%}else{ %>
								<option value="active">Active</option>
								<option value="inactive">Inactive</option>
							<%} %>
							</select>
						</div>
						<button type="submit" class="btn btn-primary">Update</button>
					</form>
				</div>
				</div>
			</div>
		</div>
	</div>
	<div style="margin-top:40px;"><%@include file="footer.jsp" %></div>
</body>
</html>