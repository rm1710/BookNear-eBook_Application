package com.admin.servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import com.DAO.BookDAOImpl;
import com.DB.DBconnect;
import com.entity.BookDtls;


@WebServlet("/editbooks")
public class EditBooksServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int id=Integer.parseInt(req.getParameter("id"));
			String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String status = req.getParameter("status");
            
            BookDtls b=new BookDtls();
            b.setBookId(id);
            b.setBookName(bookName);
            b.setAuthor(author);
            b.setPrice(price);
            b.setStatus(status);
            
            BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
            boolean f=dao.updateEditBooks(b);
            
            HttpSession session=req.getSession();
            if(f) {
            	session.setAttribute("succMsg", "Book update successfully..");
            	resp.sendRedirect("admin/all_books.jsp");
            }else {
            	session.setAttribute("failedMsg", "book is not updated successfully");
            	resp.sendRedirect("admin/all_books.jsp");
            }
            
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
