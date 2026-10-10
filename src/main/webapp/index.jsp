<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="com.DB.*" %>
<%@ page import="com.DAO.*" %>
<%@ page import="com.entity.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1" name="viewport" content="width=device-width, initial-scale=1.0">
<title>eBook</title>
<%@include file="all_component/allCss.jsp"%>
<style type="text/css">
.dynamic-back-img {
    height: 55vh;
    width: 100%;
    background-repeat: no-repeat;
    background-size: cover; 
    transition: background 0.5s ease-in-out;
  }

body {
  background-color: #e0f7fa;
  font-family: 'YourChosenFont', sans-serif;
}

.container-fluid {
  perspective: 1000px;
}

.back-img {
  transform: translateZ(50px);
  transition: transform 0.5s ease;
}

.back-img:hover {
  transform: rotateX(10deg) translateZ(50px);
}

.card {
  transition: transform 0.5s ease, box-shadow 0.3s ease, margin 0.3s ease;
  margin-bottom: 20px;
}

.card:hover {
  transform: scale(1.03);
  box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.3);
  background-color: #f9fbe7;
}

@keyframes moveSentence {
    0% {
        transform: translateY(20px) scale(0.8) rotate(0deg);
        opacity: 0;
    }
    100% {
        transform: translateY(0) scale(1) rotate(0);
        opacity: 1;
    }
}

.container-fluid {
    text-align: left;
}

.text-Left {
    color: #ffffff;
    font-size: 50px;
}

.animated-sentence {
    font-size: 35px;
    margin-top: 0px;
    animation: moveSentence 1.5s cubic-bezier(0.68, -0.55, 0.27, 1.55);
}

</style>
<script>
  $(document).ready(function() {
    var imageUrls = [
      'img/ebook1.jpg',
      'img/ebook2.jpg',
      'img/ebo.png'
      // Add more image URLs as needed
    ];

    var currentImageIndex = 0;

    function changeBackgroundImage() {
      $('.back-img').removeClass('back-img').addClass('dynamic-back-img');
      $('.dynamic-back-img').css('background-image', 'url(' + imageUrls[currentImageIndex] + ')');
      currentImageIndex = (currentImageIndex + 1) % imageUrls.length;
    }

    changeBackgroundImage();

    setInterval(changeBackgroundImage, 2500);
  });
</script>
</head>
<body style="background-color: #e0f7fa;">

	<%
	User u=(User)session.getAttribute("userobj");
	%>
	<%@include file="all_component/navbar.jsp"%>
	<div class="container-fluid back-img">
		<h1 class="text-Left animated-sentence" style="color: #ffffff; font-size: 50px;">Discover
			new reads online</h1>
		<p class="animated-sentence" style="color: #ffffff; font-size: 35px;">Explore a wide
			collection of books and order conveniently from the comfort of your
			home</p>
			<div class="line"></div>
	        <div class="line"></div>
	</div>
	<hr>

	<!-- Start Recent book -->

	<div class="container">
		<h3 class="text-center">RECENT BOOK</h3>
		<div class="row">
			<%
			BookDAOImpl dao2=new BookDAOImpl(DBconnect.getconn());
			List<BookDtls> list2=dao2.getRecentBook();
			for(BookDtls b:list2){
			%>
			<div class="col-md-3">
			<div class="card crd-ho" style="margin-right:-24px">
					<div class="card-body text-center" >
						<img src="<%=b.getPhotoName() %>"
							style="width: 160px; height: 200px;">
						<p align="left"><b>Book Name: </b><%=b.getBookName() %></p>
						<p align="left"><b>Author: </b><%=b.getAuthor() %></p>
						<p align="left"><b>Book Category: </b><%=b.getBookCategory() %></p>
						
						<p align="left">
						
						<%
						if(b.getCategory().equals("old")){ 
						%>
						
						<b>Category: </b><%=b.getCategory() %></p>
							<div class="row-center">
								<a href="view_books.jsp?bid=<%=b.getBookId() %>" class="btn btn-success btn-sm ml-1">View Details</a> 
								<a href="" class="btn btn-danger btn-sm ml-1" style=" pointer-events: none" id="viewdetail"><i class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
							</div>
						<%}else{%>
						<b>Category: </b><%=b.getCategory() %></p>
						<div class="row">
						<%if(u==null) {%>
								<a href="login.jsp" class="btn btn-danger btn-sm"><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%}else{%>
								<a href="cart?bid=<%=b.getBookId() %>&&uid=<%=u.getId() %>" class="btn btn-danger btn-sm" ><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%} %>
							
							<a href="view_books.jsp?bid=<%=b.getBookId() %>" class="btn btn-success btn-sm ml-1" >View Details</a> 
							<a href="" class="btn btn-danger btn-sm ml-1" style=" pointer-events: none" id="viewdetail"><i class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
						</div>
						<%} %>
						
					</div>
				</div>
				</div>
			<%
			}
			%>	
			</div>
		
		<div class="text-center mt-1">
			<a href="all_recent_book.jsp" class="btn btn-danger btn-sm mt-2 fa-1x" id="click">View all</a>
		</div>
	</div>
	<!-- End Recent Book -->

	<hr>

	<!-- Start New book -->
	
	<div class="container">
		<h3 class="text-center">NEW BOOK</h3>
		<div class="row">
			<%
			BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
			List<BookDtls> list=dao.getNewBook();
			for(BookDtls b:list){
			%>
			<div class="col-md-3">
			<div class="card crd-ho" style="margin-right:-24px">
					<div class="card-body text-center" >
						<img src="<%=b.getPhotoName() %>" alt=""
							style="width: 160px; height: 200px;">
						<p align="left"><b>Book Name: </b><%=b.getBookName() %></p>
						<p align="left"><b>Author: </b><%=b.getAuthor() %></p>
						<p align="left"><b>Book Category: </b><%=b.getBookCategory() %></p>
						<p align="left"><b>Category: </b><%=b.getCategory() %></p>
						<div class="row">
							
							<%if(u==null) {%>
								<a href="login.jsp" class="btn btn-danger btn-sm" ><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%}else{%>
								<a href="cart?bid=<%=b.getBookId() %>&&uid=<%=u.getId() %>" class="btn btn-danger btn-sm" ><i class="fa-solid fa-cart-plus"></i>Add to Cart</a>
							<%} %>
							<a href="view_books.jsp?bid=<%=b.getBookId() %>" class="btn btn-success btn-sm ml-1" >View Details</a> 
							<a href="" class="btn btn-danger btn-sm ml-1" style=" pointer-events: none" id="viewdetail"><i class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
						</div>
					</div>
				</div>
				</div>
			<%
			}
			%>	
			</div>
		
		<div class="text-center mt-1">
			<a href="all_new_book.jsp" class="btn btn-danger btn-sm mt-2 fa-1x" id="click">View all</a>
		</div>
	</div>
	<!-- End new Book -->

	<hr>

	<!-- Start old book -->
	<div class="container">
		<h3 class="text-center">OLD BOOK</h3>
		<div class="row">
			<%
			BookDAOImpl dao3=new BookDAOImpl(DBconnect.getconn());
			List<BookDtls> list3=dao3.getOldBook();
			for(BookDtls b:list3){
			%>
			<div class="col-md-3">
			<div class="card crd-ho" style="margin-right:-20px">
					<div class="card-body text-center" >
						<img src="<%=b.getPhotoName() %>" alt=""
							style="width: 160px; height: 200px;">
						<p align="left"><b>Book Name: </b><%=b.getBookName() %></p>
						<p align="left"><b>Author: </b><%=b.getAuthor() %></p>
						<p align="left"><b>Book Category: </b><%=b.getBookCategory() %></p>
						<p align="left"><b>Category: </b><%=b.getCategory() %></p>
						<div class="row-center">
								 <a href="view_books.jsp?bid=<%=b.getBookId() %>" class="btn btn-success btn-sm ml-1" >View Details</a> 
								 <a href="" style=" pointer-events: none" class="btn btn-danger btn-sm ml-1" id="viewdetail"><i class="fa-solid fa-indian-rupee-sign"></i> <%=b.getPrice() %></a>
						</div>
					</div>
				</div>
				</div>
			<%
			}
			%>
		</div>
		<div class="text-center mt-1">
			<a href="all_old_book.jsp" class="btn btn-danger btn-sm mt-2 fa-1x" id="click">View all</a>
		</div>
	</div>
	<!-- End old Book -->

	<div class="mt-2"><%@include file="all_component/footer.jsp"%></div>
</body>
</html>