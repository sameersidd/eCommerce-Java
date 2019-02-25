/*
 * This is the DATABASE ACCESS OBJECT
 * which handles all the database
 * interaction with the database
 * */
package com.esite;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DAO {
    public boolean login (String email, String pass){
        String query = "SELECT * FROM `users` WHERE `email` = ? AND `password` = ?" ;
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(query);
            pt.setString(1, email);
            pt.setString(2, pass);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                return true;
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return false;
    }

    public void signUp (String name, String email, String pass, String contact, String city, String address){
        String query = "INSERT INTO `users` (`id`, `name`, `email`, `password`, `contact`, `city`, `address`) VALUES (NULL, ?, ?, ?, ?, ?, ?)";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(query);
            pt.setString(1, name);
            pt.setString(2, email);
            pt.setString(3, pass);
            pt.setString(4, contact);
            pt.setString(5, city);
            pt.setString(6, address);
            pt.executeUpdate();
            con.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public String getName(String email, String pass){
        String nameQuery = "SELECT name FROM `users` WHERE `email` = ? AND `password` = ?";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        String name = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(nameQuery);
            pt.setString(1, email);
            pt.setString(2, pass);
            ResultSet rs = pt.executeQuery();
            if(rs.next()){
                name =  rs.getString("name");
            }
            con.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return name;
    }

    public void changeAccount(String name, String parameter, String value){
        String updateQuery = "UPDATE `users` SET " + parameter + " = ? WHERE name = ?;";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(updateQuery);
            pt.setString(1,value);
            pt.setString(2,name);
            pt.executeUpdate();
            con.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public void changePassword(String name, String pass, String oldPass){
        String updateQuery = "UPDATE users SET password = ? WHERE name = ? AND password = ?";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(updateQuery);
            pt.setString(1, pass);
            pt.setString(2, name);
            pt.setString(3, oldPass);
            pt.executeUpdate();
            con.close();
            }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public void deleteAccount(String name, String pass){
        String deleteQuery = "DELETE FROM users WHERE name = ? AND password = ?";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(deleteQuery);
            pt.setString(1,name);
            pt.setString(2,pass);
            pt.executeUpdate();
            con.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public void confirmItem(String name, String itemID, int quantity){
        /*Get Items one by one and confirm them i.e set order status to 'Added To Cart'*/
        String confirmItemQuery = "INSERT INTO `orders` (`order_id`, `user_id`, `item_id`, `quantity`, `order_status`) VALUES (NULL,(SELECT id FROM users WHERE name = ?),?,?,'Added To Cart')";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(confirmItemQuery);
            pt.setString(1,name);
            pt.setString(2,itemID);
            pt.setInt(3,quantity);
            pt.executeUpdate();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }

    public void deleteItem(String name, String itemID){
        /*Get Items one by one and confirm them i.e set order status to 'Added To Cart'*/
        String deleteItemQuery = "DELETE FROM `orders` WHERE user_id = (SELECT id FROM `users` WHERE name = ?) AND item_id = ? AND order_status = 'Added To Cart';";
        String url = "jdbc:mysql://localhost:3306/lifestylestore";
        String username = "estore";
        String password = "1234";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection(url, username, password);
            PreparedStatement pt = con.prepareStatement(deleteItemQuery);
            pt.setString(1,name);
            pt.setString(2,itemID);
            pt.executeUpdate();
        }
        catch (Exception e){
            e.printStackTrace();
        }
    }
}
