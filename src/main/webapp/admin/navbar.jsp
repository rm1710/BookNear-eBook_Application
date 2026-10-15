<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false"%>

<div class="container-fluid" style="height:10px; background-color:#33ccff"></div>

<div class="container-fluid p-3 bg-light">
	<div class="row">
		<div class="col-md-3 text-success">
			<h2><img src="../img/Eboo.png" height="110px" width="110px" style="margin-top:-40px; margin-bottom:-50px;"></h2>
		</div>

		<div class="col-md-3" align="right" style="margin-left:600px;margin-top:5px;">
			<c:if test="${not empty userobj }">
				<a href="" class="btn text-dark"style="margin-left:-220px; pointer-events: none; margin-top:-12px" ><img src="../img/cont.png" height="45px" width="50px">Welcome, ${userobj.name }</a> 
				<a data-toggle="modal" style="margin-top:-12px" id="click"data-target="#exampleModal" class="btn btn-primary"><i class="fa-solid fa-right-to-bracket"></i>Logout</a>
			</c:if>
			
			<c:if test="${empty userobj }">
			<a href="../login.jsp" class="btn btn-success" id="click"><i class="fa-solid fa-right-to-bracket"></i> Login</a> 
			<a href="../register.jsp" class="btn btn-primary" id="click"><i class="fa-solid fa-user-plus"></i> Register</a>
			</c:if>
		</div>
	</div>
</div>

<!-- Logout Modal -->
<!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="text-center">
        	<h4>Do you want logout? </h4>
         	<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
         	<a href="../logout"type="button" class="btn btn-primary text-white">Logout</a>
        </div>
      </div>
      <div class="modal-footer">
       
      </div>
    </div>
  </div>
</div>
<!-- end logout modal -->

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>

	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<li class="nav-item active"><a class="nav-link" id="nav" href="home.jsp"><i class="fa-solid fa-house"></i> Home
					<span class="sr-only">(current)</span>
			</a></li>
		</ul>
	</div>
</nav>