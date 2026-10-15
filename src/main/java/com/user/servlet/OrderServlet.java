package com.user.servlet;

import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.DAO.*;
import com.DB.DBconnect;
import com.entity.*;
import java.util.*;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.io.IOException;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.*;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int id=Integer.parseInt(req.getParameter("id"));
			
			HttpSession session=req.getSession();
			
			String name=req.getParameter("uname");
			String email=req.getParameter("email");
			String phno=req.getParameter("phno");
			String address=req.getParameter("address");
			String landmark=req.getParameter("lm");
			String district=req.getParameter("dist");
			String state=req.getParameter("state");
			String pincode=req.getParameter("pincode");
			String paymentType=req.getParameter("payment");
			
			String fulladd=address+","+landmark+","+district+"-"+pincode+","+state;
			
			CartDAOImpl dao= new CartDAOImpl(DBconnect.getconn());
			
			List<Cart> list=dao.getBookByUser(id);
			
			if(list.isEmpty()) {
				session.setAttribute("failedMsg", "Add Book into cart");
				resp.sendRedirect("checkout.jsp");
			}else {
				BookOrderImpl dao2=new BookOrderImpl(DBconnect.getconn());
				
				Book_order o = null;
				
				ArrayList<Book_order> orderList=new ArrayList<Book_order>();
				
				Timestamp currentTimestamp = new java.sql.Timestamp(System.currentTimeMillis());
				
				Random r=new Random();
				for(Cart c:list) {
					o=new Book_order();
					o.setOrderId("BOOK-ORD-00"+r.nextInt(1000));
					o.setUname(name);
					o.setEmail(email);
					o.setPhno(phno);
					o.setFulladd(fulladd);
					o.setBookName(c.getBookName());
					o.setAuthor(c.getAuthor());
					o.setPrice(c.getPrice()+"");
					o.setPaymentType(paymentType);
					o.setOrderTimestamp(currentTimestamp);
					
					orderList.add(o);
				}
				
				
				if("noselect".equals(paymentType)) {
					session.setAttribute("failedMsg", "Please Choose payment Method");
					resp.sendRedirect("checkout.jsp");
				}else if("Card Payment".equalsIgnoreCase(paymentType)) {
					boolean f = dao2.saveOrder(orderList);
					sendEmail(email,orderList);
//					resp.sendRedirect("RazorPay.jsp");
					resp.sendRedirect("order_success.jsp");
				}else {
					boolean f = dao2.saveOrder(orderList);
					if(f) {
						sendEmail(email,orderList);
						resp.sendRedirect("order_success.jsp");
					}else {
						session.setAttribute("failedMsg", "Your Order failed");
						resp.sendRedirect("checkout.jsp");
					}
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	private void sendEmail(String recipientEmail, List<Book_order> orderList) {
		 String senderEmail = "ebookrm7@gmail.com";
		 String senderPassword = "tdqm wdhu ojjd weae";
		 double totalAmount = 0.0;
		
	        LocalDateTime dateTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String dateTimeStr = dateTime.format(formatter);
	        
	        StringBuilder emailContent = new StringBuilder();
	        emailContent.append("Dear User,\n\nYour payment was successful. Thank you for your purchase.\n\n");
	        for (Book_order order : orderList) {
	            emailContent.append("Order ID: ").append(order.getOrderId()).append("\n");
	            emailContent.append("Recipient Name: ").append(order.getUname()).append("\n");
	            emailContent.append("Book: ").append(order.getBookName()).append("\n");
	            emailContent.append("Author: ").append(order.getAuthor()).append("\n");
	            emailContent.append("Price: ").append(order.getPrice()).append("\n");
	            emailContent.append("Payment Method: ").append(order.getPaymentType()).append("\n");
	            emailContent.append("Date & Time: ").append(dateTimeStr).append("\n");
	            emailContent.append("\n");
	            totalAmount += Double.parseDouble(order.getPrice());
	        }
	        emailContent.append("Total Amount you have pay: ").append(totalAmount).append("\n");
	        emailContent.append("\nWith in 7 days your Book will be Delivered on your Address\n");
	        emailContent.append("\nSincerely,\neBook");
		 
		 Properties props = new Properties();
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "true");
	        props.put("mail.smtp.host", "smtp.gmail.com");
	        props.put("mail.smtp.port", "587");
	        
	        
	        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(senderEmail, senderPassword);
	            }
	        });

	        try {
	            Message message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(senderEmail));
	            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
	            message.setSubject("Order Details");
	            message.setText(emailContent.toString());
	            Transport.send(message);
	            System.out.println("Email sent successfully to " + recipientEmail);
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }
	 }
	
}
