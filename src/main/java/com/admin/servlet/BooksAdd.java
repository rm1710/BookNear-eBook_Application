package com.admin.servlet;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;

import com.entity.BookDtls;
import com.DAO.BookDAOImpl;
import com.DB.DBconnect;
import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

@WebServlet("/add_books")
@MultipartConfig
public class BooksAdd extends HttpServlet {

    private Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
            "cloud_name", "dpvix5zyh",
            "api_key", "851947653551952",
            "api_secret", "weU2yccF-BqqnkmWTvkJY4p876Y"
    ));

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String bookcategories = req.getParameter("bookcategory");
            String categories = req.getParameter("category");
            String status = req.getParameter("status");

            Part filepart = req.getPart("bimg");

            String imgUrl = "";  
            if (filepart != null && filepart.getSize() > 0) {

                InputStream is = filepart.getInputStream();
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();

                int nRead;
                byte[] data = new byte[1024];

                while ((nRead = is.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }

                buffer.flush();
                byte[] fileBytes = buffer.toByteArray();

                Map uploadResult = cloudinary.uploader().upload(
                        fileBytes,
                        ObjectUtils.emptyMap()
                );

                imgUrl = uploadResult.get("secure_url").toString();

                is.close();
            }

            // ✅ Save URL in DB
            BookDtls b = new BookDtls(
                    bookName,
                    author,
                    price,
                    bookcategories,
                    categories,
                    status,
                    imgUrl,
                    "admin"
            );

            BookDAOImpl dao = new BookDAOImpl(DBconnect.getconn());
            boolean f = dao.addBooks(b);

            HttpSession session = req.getSession();

            if (f) {
                session.setAttribute("succMsg", "Book added successfully");
                resp.sendRedirect("admin/add_books.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server");
                resp.sendRedirect("admin/add_books.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}