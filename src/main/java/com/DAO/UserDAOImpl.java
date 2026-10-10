package com.DAO;

import java.sql.*;

import com.entity.User;

public class UserDAOImpl implements UserDAO {

    private Connection conn;

    public UserDAOImpl(Connection conn) {
        super();
        this.conn = conn;
    }

    public boolean userRegister(User us) {
        boolean f = false;

        try {
            String sql = "insert into user(name,email,phno,password,question,answer) values(?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, us.getName());
            ps.setString(2, us.getEmail());
            ps.setString(3, us.getPhno());
            ps.setString(4, us.getPassword());
            ps.setString(5, us.getQuestion());
            ps.setString(6, us.getAnswer());

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    
    
    @Override
	public boolean userAdminRegister(User us) {
    	 boolean f = false;

         try {
             String sql = "insert into admin(name,email,password) values(?,?,?)";
             PreparedStatement ps = conn.prepareStatement(sql);
             ps.setString(1, us.getName());
             ps.setString(2, us.getEmail());
             ps.setString(3, us.getPassword());

             int i = ps.executeUpdate();
             if (i == 1) {
                 f = true;
             }
         } catch (Exception e) {
             e.printStackTrace();
         }

         return f;
	}

    
    
	public User login(String email, String password) {
        User us = null;

        try {
            String sql = "select * from user where email=? and password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                us = new User();
                us.setId(rs.getInt(1));
                us.setName(rs.getString(2));
                us.setEmail(rs.getString(3));
                us.setPhno(rs.getString(4));
                us.setPassword(rs.getString(5));
                us.setQuestion(rs.getString(6));
                us.setAnswer(rs.getString(7));
               
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return us;
    }
	
	public User isadmin(String email, String password) {
		User us = null;
		
		try {
			String sql = "select * from admin where email=? and password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, password);
			
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				us = new User();
				us.setId(rs.getInt(1));
				us.setName(rs.getString(2));
				us.setEmail(rs.getString(3));;
				us.setPassword(rs.getString(4));
		
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return us;
	}

	
	@Override
	public boolean admin(String email, String password) {
		boolean us = false;

        try {
            String sql = "select * from admin where email=? and password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
                if (rs.next()) {
                    us = true;
                }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return us;
	}

	@Override
	public String fsq(String email) {
		String securityQuestion = null;
        try {
            String sql = "SELECT question FROM user WHERE email = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                securityQuestion = rs.getString("question");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return securityQuestion;
	}
	
	@Override
	public boolean vsc(String email, String question, String answer) {
		boolean f=false;
		try {
			String sql = "SELECT * FROM user WHERE email = ? AND question = ? AND answer = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, question);
            pstmt.setString(3, answer);
            ResultSet rs = pstmt.executeQuery();
            return rs.next();
            
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	
	
	
	@Override
	public boolean updatePassword(String email, String newPassword) {
		try {
			 String sql = "UPDATE user SET password = ? WHERE email = ?";
	            PreparedStatement pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, newPassword);
	            pstmt.setString(2, email);
	            int rowsAffected = pstmt.executeUpdate();
	            return rowsAffected > 0;
		}catch(Exception e) {
			e.printStackTrace();
			return false;
		}
	}
	
	@Override
	public boolean checkPassword(int id,String ps) {
		boolean f=false;
		try {
			String sql="select * from user where id=? and password=?";
			PreparedStatement pst=conn.prepareStatement(sql);
			pst.setInt(1,id);
			pst.setString(2,ps);
			
			ResultSet rs=pst.executeQuery();
			while(rs.next()) {
				f=true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return f;
	}
	
	@Override
	public boolean updateProfile(User us) {
		 boolean f = false;

	        try {
	            String sql = "update user set name=?,email=?,phno=?,question=?,answer=? where id=? ";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, us.getName());
	            ps.setString(2, us.getEmail());
	            ps.setString(3, us.getPhno());
	            ps.setString(4, us.getQuestion());
	            ps.setString(5, us.getAnswer());
	            ps.setInt(6,us.getId());
	            
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
	public boolean checkUser(String em) {
		boolean f=true;
		try {
			String sql = "select * from user where email=?";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, em);
            
            ResultSet rs=ps.executeQuery();
            while(rs.next()) {
            	f=false;
            }
		}catch(Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	
    
}
