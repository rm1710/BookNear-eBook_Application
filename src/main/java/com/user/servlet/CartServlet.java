package com.user.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;

import com.DAO.BookDAOImpl;
import com.DAO.CartDAOImpl;
import com.DB.DBconnect;
import com.entity.BookDtls;
import com.entity.Cart;

import javax.servlet.annotation.*;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int bid=Integer.parseInt(req.getParameter("bid"));
			int uid=Integer.parseInt(req.getParameter("uid"));
			
			BookDAOImpl doa=new BookDAOImpl(DBconnect.getconn());
			BookDtls b=doa.getBookById(bid);
			
			Cart c=new Cart();
			c.setBid(bid);
			c.setUserId(uid);
			c.setBookName(b.getBookName());
			c.setAuthor(b.getAuthor());
			c.setPrice(Double.parseDouble(b.getPrice()));
			c.setTotalPrice(Double.parseDouble(b.getPrice()));
			
			CartDAOImpl dao2=new  CartDAOImpl(DBconnect.getconn());
			boolean f=dao2.addCart(c);
			
			HttpSession session=req.getSession();
			
			if(f) {
				session.setAttribute("addCart", "Book Added into Cart");
				resp.sendRedirect("all_new_book.jsp");
				
			}else {
				session.setAttribute("failed", "Book is not added into Cart");
				resp.sendRedirect("all_new_book.jsp");
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
