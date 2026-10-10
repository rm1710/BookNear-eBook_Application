package com.user.servlet;

import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import com.DAO.*;
import com.DB.*;
import com.entity.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        try {

            String email = req.getParameter("email");
            String password = req.getParameter("password");


            if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

                session.setAttribute("failedMsg", "All fields are required!");
                resp.sendRedirect("login.jsp");
                return;
            }

            // Email format validation
            String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
            if (!Pattern.matches(emailRegex, email)) {
                session.setAttribute("failedMsg", "Invalid Email Format!");
                resp.sendRedirect("login.jsp");
                return;
            }

            // Password length validation
            if (password.length() < 6) {
                session.setAttribute("failedMsg", "Password must be at least 6 characters!");
                resp.sendRedirect("login.jsp");
                return;
            }


            String hashedPassword = xpwd(password);

            if (hashedPassword == null) {
                session.setAttribute("failedMsg", "Something went wrong. Try again!");
                resp.sendRedirect("login.jsp");
                return;
            }

            UserDAOImpl dao = new UserDAOImpl(DBconnect.getconn());

            if (dao.admin(email, password)) {

                User adminUser = dao.isadmin(email, password);

                if (adminUser != null) {
                    session.setAttribute("userobj", adminUser);
                    resp.sendRedirect("admin/home.jsp");
                } else {
                    session.setAttribute("failedMsg", "Email & Password is Invalid");
                    resp.sendRedirect("login.jsp");
                }

            } else {

                User us = dao.login(email, hashedPassword);

                if (us != null) {
                    session.setAttribute("userobj", us);
                    resp.sendRedirect("index.jsp");
                } else {
                    session.setAttribute("failedMsg", "Email & Password is Invalid");
                    resp.sendRedirect("login.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("failedMsg", "Server Error! Please try again.");
            resp.sendRedirect("login.jsp");
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
}
