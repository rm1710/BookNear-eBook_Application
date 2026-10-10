package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import org.json.JSONObject;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;

@WebServlet("/create_order")
public class OrderCreationServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String amountStr = req.getParameter("amount");
            if (amountStr == null || amountStr.isEmpty()) {
                throw new IllegalArgumentException("Amount is missing");
            }


            RazorpayClient client = new RazorpayClient("rzp_test_EwYRCdHx48ZnvH", "of1pEVnQfIepsy8m6pNjAWoI");

            JSONObject orderRequest = new JSONObject();
            orderRequest.put("amount", Integer.parseInt(amountStr));
            orderRequest.put("currency", "INR");
            orderRequest.put("receipt", "order_rcptid_11");

            Order order = client.orders.create(orderRequest);

            resp.setContentType("application/json");
            resp.getWriter().write(order.toString());

        } catch (Exception e) {
            e.printStackTrace();
            resp.setContentType("application/json");
            resp.getWriter().write("{\"error\":\"Failed to create order: " + e.getMessage() + "\"}");
        }
    }
}
