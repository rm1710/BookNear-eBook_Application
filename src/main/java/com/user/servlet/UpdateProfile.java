package com.user.servlet;

import javax.servlet.annotation.*;
import javax.servlet.http.*;
import com.DAO.UserDAOImpl;
import com.DB.DBconnect;
import com.entity.User;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import javax.servlet.*;

@WebServlet("/update_profile")
public class UpdateProfile extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try{
			int id=Integer.parseInt(req.getParameter("id"));
			String name = req.getParameter("fname");
	        String email = req.getParameter("email");
	        String phno = req.getParameter("phno");
	        String qns = req.getParameter("question");
            String ans = req.getParameter("answer");
	        String passwd = req.getParameter("password");
	        
	        String password=xpwd(passwd);
	        String asr=answer(ans);
	        
	        User us=new User();
	        us.setId(id);
	        us.setName(name);
	        us.setEmail(email);
	        us.setPhno(phno);
	        us.setQuestion(qns);
	        us.setAnswer(asr);
	        
	        
	        HttpSession session=req.getSession();
	        UserDAOImpl dao=new UserDAOImpl(DBconnect.getconn());
	        boolean f=dao.checkPassword(id, password);
	        
	        if(f) {
	        	boolean f2=dao.updateProfile(us);
	        	if(f2) {
	        		 session.setAttribute("succMsg", "Profile Updated Successfully...");
	                    resp.sendRedirect("Edit_profile.jsp");
	        	}else {
	        		 session.setAttribute("failedMsg", "Profile is not updated");
	                    resp.sendRedirect("Edit_profile.jsp");
	        	}
	        }else {
	        	 session.setAttribute("failedMsg", "Your password is Incorrect");
                 resp.sendRedirect("Edit_profile.jsp");
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
