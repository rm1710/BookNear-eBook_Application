package com.DAO;

import com.entity.*; 
import java.util.*; 

public interface BookOrderDAO {
	
	public boolean saveOrder(List<Book_order> list);
	
	public List<Book_order>getBook(String email);
	
	public boolean cancelOrder(int id);
	
	public List<Book_order> getAllOrder();
	
}
