package com.user.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.DAO.BookDAOImpl;
import com.DB.DBconnect;

@WebServlet("/delete_old_book")
public class DeleteOldBook extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String em=req.getParameter("em");
			int id=Integer.parseInt(req.getParameter("id"));
			BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
			boolean f=dao.oldBookDelete(em,"Old",id);
			HttpSession session=req.getSession();
			
			if(f) {
				session.setAttribute("succMsg", "Old Book is Deleted successfully");
				resp.sendRedirect("old_book.jsp");
			}else {
				session.setAttribute("failedMsg", "Old Book is not Deleted ");
				resp.sendRedirect("old_book.jsp");
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

}
