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
<title>Your Order</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">
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
<body style="background-color: #e8f5e9;">

	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>
	
	

	<%@include file="all_component/navbar.jsp"%>
		<div class="container">
		<h3 class="text-center mt-2">Your Orders</h3>
			<table class="table table-striped mt-3">
			  <thead class="bg-info text-white">
			    <tr>
			      <th scope="col">Order Id</th>
			      <th scope="col">Name</th>
			      <th scope="col">Book Name</th>
			      <th scope="col">Author</th>
			      <th scope="col">Price</th>
			      <th scope="col">Payment Type</th>
			      <th scope="col">Date&Time</th>
			      <th scope="col">Action</th>
			    </tr>
			  </thead>
			  <tbody>
			  
			  <%
			  User u=(User)session.getAttribute("userobj");
			  BookOrderImpl dao= new BookOrderImpl(DBconnect.getconn());
			  List<Book_order> list=dao.getBook(u.getEmail());
			  for(Book_order b:list){
			  %>
			    <tr>
			      <th scope="row"><%=b.getOrderId() %></th>
			      <td><%=b.getUname() %></td>
			      <td><%=b.getBookName()%></td>
			      <td><%=b.getAuthor() %></td>
			      <td><%=b.getPrice() %></td>
			      <td><%=b.getPaymentType() %></td>
			      <td><%=b.getOrderTimestamp() %></td>
			      <td><a href="cancelOrder?id=<%=b.getId() %>&&cardpayment=<%=b.getPaymentType() %>" class="btn btn-danger">Cancel Order</a></td>
			    </tr>
			    <%} %>
			  </tbody>
			</table>
		</div>
</body>
</html>