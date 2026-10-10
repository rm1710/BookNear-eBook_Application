package com.user.servlet;

import java.io.IOException;

import javax.servlet.http.*;

import com.DAO.CartDAOImpl;
import com.DB.DBconnect;

import javax.servlet.annotation.*;
import javax.servlet.*;

@WebServlet("/remove_book")
public class RemoveBookCart extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int bid=Integer.parseInt(req.getParameter("bid"));
		int uid=Integer.parseInt(req.getParameter("uid"));
		int cid=Integer.parseInt(req.getParameter("cid"));
		CartDAOImpl dao=new CartDAOImpl(DBconnect.getconn());
		boolean f=dao.deleteBook(bid,uid,cid);
		HttpSession session=req.getSession();
		
		
		if(f) {
			session.setAttribute("succMsg", "Book Removed from Cart");
			resp.sendRedirect("checkout.jsp");
		}else {
			session.setAttribute("failedMsg","Booked is not Removed from cart");
			resp.sendRedirect("checkout.jsp");
			
		}
	}
	
}
