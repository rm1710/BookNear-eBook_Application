package com.DAO;

import com.entity.*;

import java.sql.*;
import java.util.*;

public class CartDAOImpl implements CartDAO {
	private Connection conn;
	
	public CartDAOImpl(Connection conn) {
		this.conn=conn;
	}

	@Override
	public boolean addCart(Cart c) {
		boolean f=false;
		
		try {
			String sql="insert into cart(bid,uid,bookName,author,price,total_price) values(?,?,?,?,?,?)";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1,c.getBid());
			ps.setInt(2,c.getUserId());
			ps.setString(3, c.getBookName());
			ps.setString(4, c.getAuthor());
			ps.setDouble(5,c.getPrice());
			ps.setDouble(6,c.getTotalPrice());
			
			int i=ps.executeUpdate();
			if(i==1) {
				f=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	@Override
	public boolean paymentdetails(paymentdtls p) {
		boolean f=false;
		
		try {
			String sql="insert into payment_dtls(trans_id,ch_Name,cno,cvv,email,mobNo,Amt) values(?,?,?,?,?,?,?)";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1, p.getTransId());
            ps.setString(2, p.getChName());
            ps.setString(3, p.getCno());
            ps.setString(4, p.getCvv());
            ps.setString(5, p.getEmail());
            ps.setString(6, p.getMobNo());
            ps.setString(7, p.getAmount());
			
			int i=ps.executeUpdate();
			if(i==1) {
				f=true;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	@Override
	public List<Cart> getBookByUser(int userId) {
		List<Cart> list =new  ArrayList<Cart>();
		Cart c=null;
		double totalPrice=0.00;
		try {
			String sql="select * from cart where uid=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1, userId);
			
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				c=new Cart();
				c.setCid(rs.getInt(1));
				c.setBid(rs.getInt(2));
				c.setUserId(rs.getInt(3));
				c.setBookName(rs.getString(4));
				c.setAuthor(rs.getString(5));
				c.setPrice(rs.getDouble(6));
				
				totalPrice=totalPrice+rs.getDouble(7);
				c.setTotalPrice(totalPrice);
				
				list.add(c);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public boolean deleteBook(int bid,int uid,int cid) {
		boolean f=false;
		
		try {
			String sql="delete from cart where bid=? and uid=? and cid=?";
			PreparedStatement ps=conn.prepareStatement(sql);
			ps.setInt(1, bid);
			ps.setInt(2, uid);
			ps.setInt(3, cid);
			
			int i=ps.executeUpdate();
			if(i==1) {
				f=true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	
	
	
}
