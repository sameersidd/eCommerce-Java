<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width = device-width, initial-scale = 1">
        <title>Success | Life Style Store</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <%
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
            response.setHeader("Expires","0");
            if(session.getAttribute("name") == null){
                response.sendRedirect("login.jsp");
            }
        %>
    </head>
    <body>
        <div class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>                        
                    </button>
                    <a class="navbar-brand" href="index.jsp">Lifestyle Store</a>
                </div>
                <div class="collapse navbar-collapse" id="myNavbar">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href = "products.jsp"><span class = "glyphicon glyphicon-th-list"></span> Products</a></li>
                        <li><a href = "settings.jsp"><span class = "glyphicon glyphicon-user"></span> Profile</a></li>
                        <li><a href = "logout"><span class = "glyphicon glyphicon-log-in"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        <%
            /*Query to set order status to Confirmed on user's orders where order status was 'Added to Cart'*/
            String name = (String)session.getAttribute("name");
            String updateQuantity = "UPDATE `items`, `orders` SET stock = stock-quantity WHERE (id = item_id AND user_id = (SELECT id FROM `users` WHERE name = ?) AND order_status = 'Added To Cart');";
            String successQuery =   "UPDATE `orders` SET order_status = 'Confirmed' WHERE order_status = 'Added To Cart' AND user_id = (SELECT id FROM `users` WHERE name = ?);";
            String url = "jdbc:mysql://localhost:3306/lifestylestore";
            String username = "estore";
            String password = "1234";
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection(url, username, password);
                PreparedStatement uq = con.prepareStatement(updateQuantity);
                uq.setString(1,name);
                PreparedStatement sq = con.prepareStatement(successQuery);
                sq.setString(1,name);
                uq.executeUpdate();
                sq.executeUpdate();
            }
            catch (Exception e){
                e.printStackTrace();
            }
        %>
        </div>
        <div class="container-fluid" id="content">
            <div class="col-md-12">
                <div class="jumbotron">
                    <h3 align="center">Your order is confirmed. Thank you for shopping with us.</h3><hr>
                    <p align="center">Click <a href="products.jsp">here</a> to purchase any other item.</p>
                </div>
            </div>
        </div>
        <footer>
            <div class="container">
                <center>
                    <p>Copyright &copy; Lifestyle Store. All Rights Reserved  |  Contact Us: +91 90000 00000</p>	
                </center>
            </div>
        </footer>
    </body>
</html>