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
<title>Admin: All Order</title>
<%@include file="allcss.jsp"%>
<style>
.table {
  width: 100%;
  margin-bottom: 1rem;
  color: black;
  border-collapse: collapse;
  border-spacing: 0;
  max-width: 100%;
  overflow-x: auto;
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
<h3 class="text-center">Hello Admin</h3>

<div class="table-container">
  <table class="table table-striped">
    <thead class="bg-dark">
      <tr>
        <th scope="col">Id</th>
        <th scope="col">Name</th>
        <th scope="col">Email</th>
        <th scope="col">Address</th>
        <th scope="col">Mobile No</th>
        <th scope="col">Book Name</th>
        <th scope="col">Author</th>
        <th scope="col">Price</th>
        <th scope="col">Date & Time</th>
        <th scope="col">Payment Type</th>
      </tr>
    </thead>
    <tbody>
      <%
      BookOrderImpl dao=new BookOrderImpl(DBconnect.getconn());
      List<Book_order> list=dao.getAllOrder();
      for(Book_order b:list){
      %>
      <tr>
        <th scope="row"><%=b.getOrderId() %></th>
        <td><%=b.getUname()%></td>
        <td><%=b.getEmail() %></td>
        <td><%=b.getFulladd() %></td>
        <td><%=b.getPhno() %></td>
        <td><%=b.getBookName() %></td>
        <td><%=b.getAuthor() %></td>
        <td><%=b.getPrice() %></td>
        <td><%=b.getOrderTimestamp() %></td>
        <td><%=b.getPaymentType() %></td> 
      </tr>
      <%} %>
    </tbody>
  </table>
</div>
<%@include file="footer.jsp" %>
</body>
</html>
