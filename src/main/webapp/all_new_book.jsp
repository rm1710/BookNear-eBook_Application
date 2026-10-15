<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.DB.*" %>
<%@ page import="com.DAO.*" %>
<%@ page import="com.entity.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All New Book</title>
<style>
.card {
  transition: transform 0.5s ease, box-shadow 0.3s ease, margin 0.3s ease;
  margin-bottom: 20px;
}

.card:hover {
  transform: scale(1.05);
  box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
  background-color: #f9fbe7;
}
#toast {
	min-width: 300px;
	position: fixed;
	bottom: 30px;
	left: 50%;
	margin-left: -125px;
	background: #333;
	padding: 10px;
	color: white;
	text-align: center;
	z-index: 1;
	font-size: 18px;
	visibility: hidden;
	box-shadow: 0px 0px 100px #000;
}

#toast.display {
	visibility: visible;
	animation: fadeIn 0.5, fadeOut 0.5s 2.5s;
}

@keyframes fadeIn {from { bottom:0;
	opacity: 0;
}

to {
	bottom: 30px;
	opacity: 1;
}

}
@keyframes fadeOut {form { bottom:30px;
	opacity: 1;
}

to {
	bottom: 0;
	opacity: 0;
}
}
</style>
<%@include file="all_component/allCss.jsp"%>
</head>
<body style="background-color: #e0f7fa;">
<%
User u=(User) session.getAttribute("userobj");
%>
<c:if test="${not empty addCart }">
<div id="toast">${addCart }</div>
<script type="text/javascript">
		showToast();
		function showToast(content)
		{
		    $('#toast').addClass("display");
		    $('#toast').html(content);
		    setTimeout(()=>{
		        $("#toast").removeClass("display");
		    },2000)
		}	
</script>

<c:remove var="addCart" scope="session"/>

</c:if>

<%@include file="all_component/navbar.jsp"%>
	<div class="container-fluid p-3">
		<div class="row">
			<%
			BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
			List<BookDtls> list=dao.getAllNewBooks();
			for(BookDtls b:list){
			%>
			<div class="col-md-3">
				<div class="card crd-ho" style="margin-right: -8px">
					<div class="card-body text-center">
						<img src="<%=b.getPhotoName() %>" alt=""
							style="width: 160px; height: 200px;">
						<p align="left">
							<b>Book Name: </b><%=b.getBookName() %></p>
						<p align="left">
							<b>Author: </b><%=b.getAuthor() %></p>
						<p align="left">
							<b>Book Category: </b><%=b.getBookCategory() %></p>
						<p align="left">
							<b>Category: </b><%=b.getCategory() %></p>
						<div class="row">
						<%if(u==null) {%>
								<a href="login.jsp" class="btn btn-danger btn-sm"><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%}else{%>
								<a href="cart?bid=<%=b.getBookId() %>&&uid=<%=u.getId() %>" class="btn btn-danger btn-sm"><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%} %>
							 <a href="view_books.jsp?bid=<%=b.getBookId() %>" class="btn btn-success btn-sm ml-1">View Details</a> 
							 <a href="" class="btn btn-danger btn-sm ml-1" style=" pointer-events: none" id="viewdetail"><i
								class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
						</div>
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<div class="mt-2"><%@include file="all_component/footer.jsp"%></div>
</body>
</html>