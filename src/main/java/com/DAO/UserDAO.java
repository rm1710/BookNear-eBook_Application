package com.DAO;

import com.entity.User;

public interface UserDAO {

    public boolean userRegister(User us);
    
    public boolean userAdminRegister(User us);

    public User login(String email, String password);
    
    public boolean admin(String email, String password);
    
    public boolean checkPassword(int id,String ps);
    
    public String fsq(String email);
    
    public boolean vsc(String email,String question,String answer);
    
    public boolean updatePassword(String email, String newPassword);
    
    public boolean updateProfile(User us);
    
    public boolean checkUser(String em);
    
    
}
