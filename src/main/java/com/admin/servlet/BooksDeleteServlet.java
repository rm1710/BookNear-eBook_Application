package com.admin.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import com.DAO.BookDAOImpl;
import com.DB.DBconnect;

import javax.servlet.annotation.*;


@WebServlet("/delete")
public class BooksDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int id=Integer.parseInt(req.getParameter("id"));
			
			BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
			boolean f=dao.deleteBooks(id);
			HttpSession session=req.getSession();
			
            if(f) {
            	session.setAttribute("succMsg", "Book Delete successfully..");
            	resp.sendRedirect("admin/all_books.jsp");
            }else {
            	session.setAttribute("failedMsg", "book is not delete successfully");
            	resp.sendRedirect("admin/all_books.jsp");
            }
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
