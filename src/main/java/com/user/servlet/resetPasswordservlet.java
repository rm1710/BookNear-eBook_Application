package com.user.servlet;

import java.io.*;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


import com.DB.*;
import com.DAO.UserDAOImpl;


@WebServlet("/resetpasswd")
public class resetPasswordservlet extends HttpServlet {
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        try {
        	String email = req.getParameter("email");
            String ans = req.getParameter("answer");
            String newPassword = req.getParameter("new_password");
            
            String passwd=xpwd(newPassword);
            String asr=answer(ans);
            HttpSession session = req.getSession();
            
            UserDAOImpl dao = new UserDAOImpl(DBconnect.getconn());
            String securityQuestion = dao.fsq(email);
            res.setContentType("text/plain");
            res.setCharacterEncoding("UTF-8");
            res.getWriter().write(securityQuestion != null ? securityQuestion : "");

            if (securityQuestion != null) {
                
                if (dao.vsc(email, securityQuestion, asr)) {
                    
                    if (dao.updatePassword(email, passwd)) {
                    	session.setAttribute("succMsg", "Your Password Reset!!");
                        res.sendRedirect("login.jsp");
                    } else {
                        session.setAttribute("failedMsg", "Failed to reset password. Please try again.");
                        req.getRequestDispatcher("forgetpasswd.jsp").forward(req, res);
                    }
                } else {
                    session.setAttribute("failedMsg", "Invalid security question and answer.");
                    req.getRequestDispatcher("forgetpasswd.jsp").forward(req, res);
                }
            } else {
                session.setAttribute("failedMsg", "security question not set.");
                req.getRequestDispatcher("forgetpasswd.jsp").forward(req, res);
            }
        }catch(Exception e) {
        	e.printStackTrace();
        }

	}
	
	private String xpwd(String password) {
		 try {
	           MessageDigest digest = MessageDigest.getInstance("SHA-256");
	            byte[] hash = digest.digest(password.getBytes());

	            StringBuilder hexString = new StringBuilder();
	            for (byte b : hash) {
	                String hex = Integer.toHexString(0xff & b);
	                if (hex.length() == 1)
	                    hexString.append('0');
	                hexString.append(hex);
	            }
	            return hexString.toString();
	        } catch (NoSuchAlgorithmException e) {
	            e.printStackTrace();
	            return null;
	        }
    }
	
	private String answer(String answer) {
		int length = 4*answer.length();
		StringBuilder xanswer= new StringBuilder();
		for (int i = 0; i < length; i++) {
			xanswer.append("x");
		}
		return xanswer.toString();
	}
}
