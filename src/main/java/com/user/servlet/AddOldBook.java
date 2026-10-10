package com.user.servlet;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

import com.DAO.BookDAOImpl;
import com.DB.DBconnect;
import com.entity.BookDtls;

@WebServlet("/add_old_book")
@MultipartConfig
public class AddOldBook extends HttpServlet {
	@Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String bookcategories = req.getParameter("bookcategory");
            String categories ="old";
            String status ="Active";
            Part filepart = req.getPart("bimg");
            String fileName =filepart.getSubmittedFileName();
            
            String useremail=req.getParameter("user");

            BookDtls b = new BookDtls(bookName, author, price, bookcategories,categories, status, fileName, useremail);
            BookDAOImpl dao=new BookDAOImpl(DBconnect.getconn());
           
            boolean f=dao.addBooks(b);
            
            HttpSession session=req.getSession();
            if(f){
            	String path=getServletContext().getRealPath("")+"books";
                File file=new File(path);
                filepart.write(path + File.separator + fileName);
            	
                session.setAttribute("succMsg","Book add Successfully");
                resp.sendRedirect("sell_book.jsp");
            }else{
                session.setAttribute("failedMsg", "Something wrong on Server");
                resp.sendRedirect("sell_book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
