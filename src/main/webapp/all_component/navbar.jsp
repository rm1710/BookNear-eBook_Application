<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<div class="container-fluid"
	style="height: 10px; background-color: #33ccff"></div>

<div class="container-fluid p-3 bg-light">
	<div class="row">
		<div class="col-md-3 text-success">
			<h2>
				<img src="img/Eboo.png" height="110px" width="110px"
					style="margin-top: -40px; margin-bottom: -50px;">
			</h2>
		</div>
		<div class="col-md-6" style="margin-left: 100px">
			<form class="form-inline my-2 my-lg-0" action="search.jsp"
				method="post">
				<input style="border: solid blue; border-radius: 1px"
					class="form-control mr-sm-2" type="search" name="ch"
					placeholder="Search Book here" aria-label="Search">
				<button class="btn btn-primary my-2 my-sm-0" id="click"
					type="submit">Search</button>
			</form>
		</div>

		<c:if test="${not empty userobj}">
			<div class="col-md-3 navbar-collapse" align="right"
				style="margin-left: -220px; margin-top: -11px;">
				<a href="" class="btn text-dark"
					style="margin-left: -220px; pointer-events: none"><img
					src="img/cont.png" height="45px" width="50px">Welcome,
					${userobj.name }</a> <a href="checkout.jsp"
					class="btn btn-warning text-dark" id="click"><img
					src="img/cart.png" height="25px" width="25px"> Cart</a> <a
					href="logout" class="btn btn-primary text-dark" id="click"
					style="margin-left: 2px; margin-right: -120px;"><i
					class="fa-solid fa-right-to-bracket"></i> Logout</a>

			</div>
		</c:if>
		<c:if test="${empty userobj }">
			<div class="col-md-3 navbar-collapse" align="right"
				style="margin-left: -100px">
				<a href="login.jsp" class="btn btn-success" id="click"><i
					class="fa-solid fa-right-to-bracket"></i> Login</a> <a
					href="register.jsp" class="btn btn-primary " id="click"><i
					class="fa-solid fa-user-plus"></i> Register</a>
			</div>
		</c:if>
	</div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" href="index.jsp"
				id="nav"><i class="fa-solid fa-house"></i> Home <span
					class="sr-only">(current)</span> </a></li>
			<li class="nav-item active"><a class="nav-link" id="nav"
				href="all_recent_book.jsp"><i
					class="fa-solid fa-book-open-reader"></i> Recent Books </a></li>
			<li class="nav-item active"><a class="nav-link" id="nav"
				href="all_new_book.jsp"><i class="fa-solid fa-book-medical"></i>
					New Books </a></li>
			<li class="nav-item active"><a class="nav-link" id="nav"
				href="all_old_book.jsp"><i class="fa-solid fa-book"></i> Old
					Books</a></li>
			<li class="nav-item dropdown"><a
				class="nav-link dropdown-toggle" href="#" id="bookDropdown"
				role="button" data-toggle="dropdown" aria-haspopup="true"
				aria-expanded="false"> <i class="fa fa-book-open"></i> Book
					Category
			</a>

				<div class="dropdown-menu" aria-labelledby="bookDropdown">
					<a class="dropdown-item" href="mythology.jsp">Mythology</a> <a
						class="dropdown-item" href="programming.jsp">Programming</a> <a
						class="dropdown-item" href="Anime.jsp">Anime</a> <a
						class="dropdown-item" href="story.jsp">Story</a> <a
						class="dropdown-item" href="novel.jsp">Novel</a> <a
						class="dropdown-item" href="scifi.jsp">Science Fiction</a> <a
						class="dropdown-item" href="Bio.jsp">Biography</a>
				</div></li>
	</div>
	</ul>
	<c:if test="${not empty userobj}">
		<form class="form-inline my-2 my-lg-0">
			<a href="setting.jsp" class="btn btn-light my-2 my-sm-0" id="click"
				type="submit"><i class="fa-solid fa-bars"></i> Menu</a>
		</form>
	</c:if>
	<c:if test="${empty userobj }">
		<a href="helpline.jsp" class="btn btn-light my-2 my-sm-0 ml-2"
			id="click" type="submit"><i class="fa-solid fa-phone"></i>
			contact us</a>
	</c:if>
	</div>
</nav>