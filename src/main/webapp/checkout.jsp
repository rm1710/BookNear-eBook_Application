<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="com.DAO.*"%>
<%@page import="com.DB.*"%>
<%@page import="com.entity.*"%>
<%@page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout Page</title>
<%@include file="all_component/allCss.jsp"%>
<style>
.card-body {
	margin: 20px;
	border: 1px solid #ddd;
	border-radius: 8px;
	overflow: hidden;
}

.table {
	width: 100%;
	transition: transform 0.3s ease-in-out;
}

th, td {
	text-align: center;
}

tr:hover {
	background-color: #e0f7fa;
	transform: scale(1.05);
}
</style>
</head>
<body style="background-color: #e0f7fa;">
	<%@include file="all_component/navbar.jsp"%>

	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp"></c:redirect>
	</c:if>

	<c:if test="${not empty succMsg}">
		<div class="alert alert-success">${succMsg}</div>
		<c:remove var="succMsg" scope="session" />
	</c:if>
	<c:if test="${not empty failedMsg}">
		<div class="alert alert-danger">${failedMsg}</div>
		<c:remove var="failedMsg" scope="session" />
	</c:if>

	<%
	User u = (User) session.getAttribute("userobj");
	CartDAOImpl dao = new CartDAOImpl(DBconnect.getconn());
	List<Cart> cart = dao.getBookByUser(u.getId());
	Double totalPrice = 0.0;
	for (Cart c : cart) {
		totalPrice += c.getTotalPrice();
	}
	%>

	<div class="container">
		<div class="row p-2">
			<div class="col-md-6">
				<div class="card bg-white mt-4">
					<div class="card-body p-2">
						<h3 class="text-center text-dark">Your Cart Books</h3>
						<table class="table table-light table-striped">
							<thead>
								<tr>
									<th>Book Name</th>
									<th>Author</th>
									<th>Price</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>
								<%
								for (Cart c : cart) {
								%>
								<tr>
									<td><%=c.getBookName()%></td>
									<td><%=c.getAuthor()%></td>
									<td><%=c.getPrice()%></td>
									<td><a
										href="remove_book?bid=<%=c.getBid()%>&&uid=<%=c.getUserId()%>&&cid=<%=c.getCid()%>"
										class="btn btn-sm btn-danger">Remove</a></td>
								</tr>
								<%
								}
								%>
								<tr>
									<td colspan="3"><strong>Total Price:</strong></td>
									<td><i class="fa-solid fa-indian-rupee-sign"></i> <%=totalPrice%></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- Order Form Section -->
			<div class="col-md-6">
				<div class="card mt-4">
					<div class="card-body">
						<h3 class="text-center">Enter Details for Order</h3>
						<form id="orderForm" method="post" action="order">
							<input type="hidden" name="id" value="${userobj.id}"> <input
								type="hidden" id="totalPrice" value="<%=totalPrice%>">

							<div class="form-group">
								<label>Name</label> <input type="text" class="form-control"
									name="uname" value="${userobj.name}" required>
							</div>

							<div class="form-group">
								<label>Email</label> <input type="email" class="form-control"
									name="email" value="${userobj.email}" required>
							</div>

							<div class="form-group">
								<label>Mobile No.</label> <input type="number"
									class="form-control" name="phno" value="${userobj.phno}"
									required>
							</div>

							<div class="form-group">
								<label>Address</label> <input type="text" class="form-control"
									name="address" placeholder="Address" required>
							</div>

							<div class="form-group">
								<label>Landmark</label> <input type="text" class="form-control"
									name="lm" placeholder="Landmark" required>
							</div>

							<div class="form-group">
								<label>District</label> <input type="text" class="form-control"
									name="dist" placeholder="District" required>
							</div>

							<div class="form-group">
								<label>State</label> <input type="text" class="form-control"
									name="state" placeholder="State" required>
							</div>

							<div class="form-group">
								<label>Pincode</label> <input type="number" class="form-control"
									name="pincode" placeholder="Pincode" required>
							</div>

							<div class="form-group">
								<label>Payment Mode</label> <select class="form-control"
									name="payment" id="paymentSelect" required>
									<option value="">--Select--</option>
									<option value="COD">Cash on Delivery</option>
									<option value="Card Payment">Online Payment</option>
								</select>
							</div>

							<div class="text-center mt-3">

								<button class="btn btn-warning me-2" type="submit">
									Order Now</button>

								<button class="btn btn-secondary me-2" type="reset">
									Clear</button>

								<a href="index.jsp" class="btn btn-success"> Continue
									Shopping </a>

							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
	<script>
		document
				.getElementById("orderForm")
				.addEventListener(
						"submit",
						function(e) {
							const paymentMode = document
									.getElementById("paymentSelect").value;
							if (paymentMode === "Card Payment") {
								e.preventDefault(); // Prevent form submit

								const amount = parseFloat(document
										.getElementById("totalPrice").value) * 100; // Convert to paise

								const options = {
									"key" : "rzp_test_EwYRCdHx48ZnvH",
									"amount" : amount,
									"currency" : "INR",
									"name" : "eBook Store",
									"description" : "Book Purchase",
									"handler" : function(response) {
										// Create a hidden input to store the payment ID
										const form = document
												.getElementById("orderForm");

										const paymentInput = document
												.createElement("input");
										paymentInput.type = "hidden";
										paymentInput.name = "razorpay_payment_id";
										paymentInput.value = response.razorpay_payment_id;
										form.appendChild(paymentInput);

										form.submit(); // Submit the form after successful payment
									},
									"prefill" : {
										"name" : document
												.querySelector('input[name="uname"]').value,
										"email" : document
												.querySelector('input[name="email"]').value,
										"contact" : document
												.querySelector('input[name="phno"]').value
									},
									"theme" : {
										"color" : "#3399cc"
									}
								};
								const rzp = new Razorpay(options);
								rzp.open();
							}
						});
	</script>
</body>
</html>
