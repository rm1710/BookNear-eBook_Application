package com.user.servlet;

import java.io.IOException;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;


import java.util.Properties;

import com.DAO.*;
import com.DB.DBconnect;
import com.entity.*;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/cardpayment")
public class paymentServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int transId = generateTransactionId(); 
	        String chName = req.getParameter("chn");
	        String cno =req.getParameter("cn");
	        String cvv = req.getParameter("cvv");
	        String email = req.getParameter("em");
	        String mobNo = req.getParameter("mob");
	        String amount = req.getParameter("amt");
	        
	        String cdno=cardno(cno);
	        String c=cardcvv(cvv);
	        
	        paymentdtls pd= new paymentdtls();
	        pd.setTransId(transId);
	        pd.setChName(chName);
	        pd.setCno(cdno);
	        pd.setCvv(c);
	        pd.setEmail(email);
	        pd.setMobNo(mobNo);
	        pd.setAmount(amount); 
	        
	        
	        
	        CartDAOImpl dao=new CartDAOImpl(DBconnect.getconn());
	        boolean success=dao.paymentdetails(pd);
	        HttpSession session = req.getSession();
	        if(success) {
	        	sendEmail(email, transId, chName, cno, cvv, mobNo,amount);
	        	resp.sendRedirect("order_success.jsp");
	        	session.setAttribute("OrsuccMsg","Payment Successful");
	        }else {
	        	resp.sendRedirect("order.jsp");
	        	session.setAttribute("OrfailedMsg","Payment is Unsuccessful");
	        }
	        	
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	private int generateTransactionId() {
	    Random random = new Random();
	    return 100000000 + random.nextInt(900000000);
	}
	
	 private void sendEmail(String recipientEmail, int transId, String chName, String cno, String cvv, String mobNo,String amount) {
		 String senderEmail = "ebookrm7@gmail.com";
		 String senderPassword = "tdqm wdhu ojjd weae";
		 
		
	        LocalDateTime dateTime = LocalDateTime.now();
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	        String dateTimeStr = dateTime.format(formatter);
	        
	        String emailContent = "Dear User,\n\nYour payment was successful. Thank you for your purchase.\n\n";
            emailContent += "Transaction ID: " + transId + "\n";
            emailContent += "Recipient Name: " + chName + "\n";
            emailContent += "Amount: " + amount + "\n";
            emailContent += "Payment Method: Card\n";
            emailContent += "Date & Time: " + dateTimeStr + "\n";
            emailContent += "\n\nWith in 7 days your Book will be Delivered on your Address\n";
            emailContent += "\nfurther Detail is added on the Your Order page \n";
            emailContent += "\nSincerely,\neBook";
		 
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
	            message.setSubject("Payment Successful");
	            message.setText(emailContent);
	            Transport.send(message);
	            System.out.println("Email sent successfully to " + recipientEmail);
	        } catch (MessagingException e) {
	            e.printStackTrace();
	        }
	 }
	 
	 private String cardcvv(String cvv) {
		int length = 3*cvv.length();
		StringBuilder xcvv= new StringBuilder();
		for (int i = 0; i < length; i++) {
			xcvv.append("x");
		}
		return xcvv.toString();
	}
	 private String cardno(String cno) {
		 int length = 3*cno.length();
		 StringBuilder xcardno= new StringBuilder();
		 for (int i = 0; i < length; i++) {
			 xcardno.append("x");
		 }
		 return xcardno.toString();
	 }
	
}
