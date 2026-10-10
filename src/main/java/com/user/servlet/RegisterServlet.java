package com.user.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.security.*;

import com.DAO.UserDAOImpl;
import com.DB.DBconnect;
import com.entity.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String name = req.getParameter("fname");
            String email = req.getParameter("email");
            String phno = req.getParameter("phno");
            String passwd = req.getParameter("password");
            String qns = req.getParameter("question");
            String ans = req.getParameter("answer");
            String check = req.getParameter("check");
            
            String hashedpasswd=xpwd(passwd);
            String asr=answer(ans);

            User us = new User();
            us.setName(name);
            us.setEmail(email);
            us.setPhno(phno);
            us.setPassword(hashedpasswd);
            us.setQuestion(qns);
            us.setAnswer(asr);

            HttpSession session = req.getSession();

            if (check != null) {

                UserDAOImpl dao = new UserDAOImpl(DBconnect.getconn());
                boolean f2=dao.checkUser(email);
                if(f2) {
                	
                	boolean f = dao.userRegister(us);

                    if (f) {
                        session.setAttribute("succMsg", "Registration Successfully...");
                        resp.sendRedirect("login.jsp");
                    } else {
                        session.setAttribute("failedMsg", "something wrong on server...");
                        resp.sendRedirect("register.jsp");
                    }
                	
                }else {
                	session.setAttribute("failedMsg", "User Already Exist Try Another Email Id");
                    resp.sendRedirect("register.jsp");
                }

            } else {
                session.setAttribute("failedMsg", "Please check Agree & Terms Condition");
                resp.sendRedirect("register.jsp");;
            }

        } catch (Exception e) {
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
