package com.DAO;

import java.util.List;

import com.entity.*;

public interface CartDAO {
	public boolean addCart(Cart c);
	public boolean paymentdetails(paymentdtls p);
	
	public List<Cart> getBookByUser(int userId);
	
	public boolean deleteBook(int bid,int uid, int cid);
	
}
