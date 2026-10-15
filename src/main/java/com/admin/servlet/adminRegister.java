package com.admin.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import com.DAO.UserDAOImpl;
import com.DB.DBconnect;
import com.entity.User;

import javax.servlet.annotation.*;

@WebServlet("/adRegis")
public class adminRegister extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String name = req.getParameter("fname");
            String email = req.getParameter("email");
            String passwd = req.getParameter("password");
            String check = req.getParameter("check");
           

            User us = new User();
            us.setName(name);
            us.setEmail(email);
            us.setPassword(passwd);


            HttpSession session = req.getSession();

            if (check != null) {

                UserDAOImpl dao = new UserDAOImpl(DBconnect.getconn());
                boolean f2=dao.checkUser(email);
                if(f2) {
                	
                	boolean f = dao.userAdminRegister(us);

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
}
