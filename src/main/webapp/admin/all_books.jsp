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
<title>Insert title here</title>
<%@include file="allcss.jsp"%>
<style>

.table {
  width: 100%;
  margin-bottom: 1rem;
  color: black;
  border-collapse: collapse;
  border-spacing: 0;
}

.table th,
.table td {
  padding: 0.75rem;
  vertical-align: top;
  border-top: 1px solid aqua;
}

.table thead th {
  vertical-align: bottom;
  border-bottom: 2px solid black;
}

.table tbody + tbody {
  border-top: 2px solid #dee2e6;
}

.table .table {
  background-color: black;
}

.table th {
  background-color: #007bff;
  color: #fff;
}

.table tbody tr:nth-child(odd) {
  background-color: #f8f9fa;
}

.table tbody tr {
  transition: background-color 0.3s ease, transform 0.3s ease;
}

.table tbody tr:hover {
  background-color: #cce5ff;
  transform: scale(1.02);
}

@keyframes fadeIn {
  from {
    opacity: 0;
  }
  to {
    opacity: 1;
  }
}

.table thead th {
  animation: fadeIn 0.5s ease-in-out;
}

.table tbody tr {
  animation: fadeIn 0.5s ease-in-out;
}
</style>
</head>
<body>
<%@include file="navbar.jsp"%>
<c:if test="${empty userobj }">
		<c:redirect url="../login.jsp"/>
	</c:if>
<h3 class="text-center"> Hello admin</h3>

<c:if test="${not empty succMsg }">
	<h3 class="text-center text-success">${succMsg }</h3>
	<c:remove var="succMsg" scope="session"/>
</c:if>


<c:if test="${not empty failedMsg }">
	<h3 class="text-center text-danger">${failedMsg }</h3>
	<c:remove var="failedMsg" scope="session"/>
</c:if>

<table class="table table-striped">
  <thead class="bg-primary">
    <tr>
      <th scope="col">Image</th>
      <th scope="col">Book Name</th>
      <th scope="col">Author</th>
      <th scope="col">Price</th>
      <th scope="col">Book Category</th>
      <th scope="col">Category</th>
      <th scope="col">Status</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
  <%
  	BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
  	List<BookDtls> list=dao.getAllBooks();
  	for(BookDtls b:list){
  %>
  <tr>
      <td><img src="<%=b.getPhotoName()%>" style="width:50px;height:50px;"></td>
      <td><%=b.getBookName() %></td>
      <td><%=b.getAuthor() %></td>
      <td><%=b.getPrice()%></td>
      <td><%=b.getBookCategory() %></td>
      <td><%=b.getCategory() %></td>
      <td><%=b.getStatus() %></td>
     <td>
     	<a href="edit_books.jsp?id=<%=b.getBookId()%>" class="btn btn-primary"><i class="fa-solid fa-pen-to-square"></i>Edit</a>
     	<a href="../delete?id=<%=b.getBookId()%>" class="btn btn-danger"><i class="fa-solid fa-trash-can"></i>Delete</a>
     </td>
    </tr>
  <%} %>
  </tbody>
</table>
</body>
</html>