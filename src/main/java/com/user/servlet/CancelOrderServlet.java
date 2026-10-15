package com.user.servlet;


import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.DAO.BookDAOImpl;
import com.DAO.BookOrderImpl;
import com.DB.DBconnect;
import com.entity.Book_order;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
            int Id = Integer.parseInt(req.getParameter("id"));
            String paymentType=req.getParameter("cardpayment");
            
            HttpSession session = req.getSession();
            
            if (Id>0) {
                BookOrderImpl dao = new BookOrderImpl(DBconnect.getconn());
                boolean isCancelled = dao.cancelOrder(Id);
                
                if (isCancelled) {
                	if("Card Payment".equals(paymentType)) {
                		session.setAttribute("OrsuccMsg", "Your order is cancel Successfully");
                		session.setAttribute("cardpay", "Your amount is refund within 7 working days");
                		resp.sendRedirect("cancelOrder.jsp");
                	}else {
                		session.setAttribute("OrsuccMsg", "Your order is cancel Successfully");
                		resp.sendRedirect("cancelOrder.jsp");
                	}
                } else {
                	
                    session.setAttribute("errorMsg", "Failed to cancel the order");
                }
            } else {
                session.setAttribute("errorMsg", "Invalid order ID");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
}
