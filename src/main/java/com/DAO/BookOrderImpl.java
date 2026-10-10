package com.DAO;

import java.sql.*;
import java.util.*;


import com.entity.Book_order;

public class BookOrderImpl implements BookOrderDAO{
	
	private Connection conn;

	public BookOrderImpl(Connection conn) {
		super();
		this.conn = conn;
	}

	@Override
	public boolean saveOrder(List<Book_order> list) {
		boolean f=false;
		try {
			String sql="insert into book_order(order_id,user_name, email, address, phone, book_name, author, price, payment,datetime) values(?,?,?,?,?,?,?,?,?,?)";
			conn.setAutoCommit(false);
			PreparedStatement ps=conn.prepareStatement(sql);
			for(Book_order b: list) {
				ps.setString(1, b.getOrderId());
				ps.setString(2, b.getUname());
				ps.setString(3, b.getEmail());
				ps.setString(4, b.getFulladd());
				ps.setString(5, b.getPhno());
				ps.setString(6, b.getBookName());
				ps.setString(7, b.getAuthor());
				ps.setString(8, b.getPrice());
				ps.setString(9, b.getPaymentType());
				ps.setTimestamp(10,b.getOrderTimestamp());
				ps.addBatch();
			}
			
			int[] count=ps.executeBatch();
			conn.commit();
			f=true;
			conn.setAutoCommit(true);
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}


	@Override
	public List<Book_order> getBook(String email) {
		List<Book_order> list = new ArrayList<Book_order>();
		Book_order o=null;
		try {
			String sql="select * from book_order where email=? ORDER BY id DESC";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setString(1, email);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				o= new Book_order();
				o.setId(rs.getInt(1));
				o.setOrderId(rs.getString(2));
				o.setUname(rs.getString(3));
				o.setEmail(rs.getString(4));
				o.setFulladd(rs.getString(5));
				o.setPhno(rs.getString(6));
				o.setBookName(rs.getString(7));
				o.setAuthor(rs.getString(8));
				o.setPrice(rs.getString(9));
				o.setPaymentType(rs.getString(10));
				o.setOrderTimestamp(rs.getTimestamp(11));
				list.add(o);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	
	@Override
	public boolean cancelOrder(int id) {
		 boolean isCancelled = false;
	        try {
	            String sql = "DELETE FROM book_order WHERE id=?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setInt(1, id);
	            int rowsAffected = ps.executeUpdate();
	            if (rowsAffected > 0) {
	                isCancelled = true;
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return isCancelled;
	}
	

	@Override
	public List<Book_order> getAllOrder() {
		List<Book_order> list = new ArrayList<Book_order>();
		Book_order o=null;
		try {
			String sql="select * from book_order ORDER BY id DESC ";
			PreparedStatement ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				o= new Book_order();
				o.setId(rs.getInt(1));
				o.setOrderId(rs.getString(2));
				o.setUname(rs.getString(3));
				o.setEmail(rs.getString(4));
				o.setFulladd(rs.getString(5));
				o.setPhno(rs.getString(6));
				o.setBookName(rs.getString(7));
				o.setAuthor(rs.getString(8));
				o.setPrice(rs.getString(9));
				o.setPaymentType(rs.getString(10));
				o.setOrderTimestamp(rs.getTimestamp(11));
				list.add(o);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
