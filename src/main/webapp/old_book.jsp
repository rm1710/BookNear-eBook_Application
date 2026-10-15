<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<%@ page import="com.DB.*" %>
<%@ page import="com.DAO.*" %>
<%@ page import="com.entity.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User:Old Book</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body>
	<%@include file="all_component/navbar.jsp"%>
	
	<c:if test="${not empty succMsg }">
		<h4 class="alert text-center alert-success mt-3">${succMsg}</h4>
		<c:remove var="succMsg" scope="session" />
	</c:if>
	
	<div class="container p-5">
		<table class="table table-striped">
		  <thead class="bg-info text-white">
		    <tr>
		      <th scope="col">book Name</th>
		      <th scope="col">Author</th>
		      <th scope="col">Price</th>
		      <th scope="col">Book Category</th>
		      <th scope="col">Category</th>
		      <th scope="col">Action</th>
		    </tr>
		  </thead>
		  <tbody>
		  <%
		  User u =(User)session.getAttribute("userobj");
		  String email=u.getEmail();
		  
		  BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
		  List<BookDtls> list=dao.getBookByOld(email,"old");
		  for(BookDtls b:list){
		  %>
		  	<tr>
		      <td><%=b.getBookName() %></td>
		      <td><%=b.getAuthor() %></td>
		      <td><%=b.getPrice() %></td>
		      <td><%=b.getBookCategory() %></td>
		      <td><%=b.getCategory() %></td>
		      <td><a href="delete_old_book?em=<%=email %>&&id=<%=b.getBookId() %>" class="btn btn-sm btn-danger" id="click">Delete</a></td>
		    </tr>
		  <%} %>
		  </tbody>
		</table>
		</div>
</body>
</html>