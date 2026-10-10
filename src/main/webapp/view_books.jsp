<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.DB.*" %>
<%@ page import="com.DAO.*" %>
<%@ page import="com.entity.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #e0f7fa;">
	<%@include file="all_component/navbar.jsp"%>
	<%
	User u=(User)session.getAttribute("userobj");
	%>
	
	<%
	int bid=Integer.parseInt(request.getParameter("bid"));
	BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
	BookDtls b=dao.getBookById(bid);
	%>
	
	
	<div class="container">
		<div class="row p-5">
			<div class="col-md-6 text-center p-5 border bg-white">
				<img src="<%=b.getPhotoName() %>" style="height: 200px; width: 150px"><br>
				<h4 align="left">
					<b>Book Name: </b><%=b.getBookName()%>
				</h4>
				<h4 align="left">
					<b>Author: </b><%=b.getAuthor()%>
				</h4>
				<h4 align="left">
					<b>Book Category: </b><%=b.getBookCategory()%>
				</h4>
				<h4 align="left">
					<b>Category: </b><%=b.getCategory()%>
				</h4>
			</div>

			<div class="col-md-6 text-center p-5 border bg-white">
				<h2><%=b.getBookName() %></h2>

				<%
				if("old".equals(b.getCategory()))
				{%>
				<h5 class="text-info">Contact To Seller</h5>
				<h5 class="text-info">
					<i class="fa-solid fa-envelope"></i> E-mail: <span
						style="color: black"><%=b.getEmail() %></span>
				</h5>
				<%
				}
				%>
				<div class="row mt-2">
					<div class="col-md-4 text-danger text-center p-2">
						<img src="img/cod.jpg" height="60px" width="60px">
						<p>Cash On Delivery</p>
					</div>
					<div class="col-md-4 text-danger text-center p-2">
						<img src="img/ret.jpg" height="60px" width="60px">
						<p>Return</p>
					</div>
					<div class="col-md-4 text-danger text-center p-2">
						<img src="img/delivery.jpg" height="60px" width="70px">
						<p>Free Shipping</p>
					</div>
				</div>

				<%if("old".equals(b.getCategory())){ %>
				<div class="text-center p-3">
					<a href="index.jsp" class="btn btn-primary">Continue Shopping</a> <a
						href="" class="btn btn-danger" ><i
						class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
				</div>
				<%
				} else {
				%>
					<%if(u==null) {%>
								<a href="login.jsp" class="btn btn-danger btn-sm"><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%}else{%>
								<a href="cart?bid=<%=b.getBookId() %>&& uid=<%=u.getId() %>" class="btn btn-danger btn-sm"><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%} %>
				 <a href=""
					class="btn btn-success btn-sm ml-1" style="pointer-events: none" id="viewdetail"><i
					class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
			</div>
			<%} %>
		</div>
		</div>
</body>
</html>