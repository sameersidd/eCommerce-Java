<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cart | Life Style Store</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <%
            response.setHeader("Cache-Control","no-cache, no-store, must-revalidate");
            response.setHeader("Expires","0");
            if(session.getAttribute("name") == null){
                response.sendRedirect("login.jsp");
            } else {
                if (session.getAttribute("cart") != null) {
                    session.setAttribute("ConfirmCart", true);
                    RequestDispatcher rd = request.getRequestDispatcher("/cart");
                    rd.include(request, response);
                }
            } //FIXME Check why cart and confirmCart are conflicting
        %>
    </head>
    <body>
        <div class="container-fluid" id="content">
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
            </div>
            <div class="row decor_bg">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">Order Details</div>
                    <%
                        /*
                         * The account details are called from the database
                         * using the Name in the session variable
                         * */
                        String sessName = (String)session.getAttribute("name");
                        String query = "SELECT * FROM `users` WHERE `name` = ?";
                        String url = "jdbc:mysql://localhost:3306/lifestylestore";
                        String username = "estore";
                        String password = "1234";
                        ResultSet rs = null;
                        String name = null;
                        String email = null;
                        String contact = null;
                        String city = null;
                        String address = null;
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection con = DriverManager.getConnection(url, username, password);
                            PreparedStatement pt = con.prepareStatement(query);
                            pt.setString(1,sessName);
                            rs = pt.executeQuery();
                            rs.next();
                            name = rs.getString("name");
                            email = rs.getString("email");
                            contact = rs.getString("contact");
                            city = rs.getString("city");
                            address = rs.getString("address");
                        }
                        catch (Exception e){
                            e.printStackTrace();
                        }
                        out.print("<table class=\"table table-striped\" style=\"width:100%\">\n" +
                                        "<tr>\n" +
                                            "<td>Name:</td><td>" + name + "</td>\n" +
                                        "</tr> \n" +
                                        "<tr> \n" +
                                            "<td>Email:</td><td>" + email + "</td>\n" +
                                        "</tr>\n" +
                                        "<tr>\n" +
                                            "<td>Contact:</td><td>" + contact + "</td>\n" +
                                        "</tr>\n" +
                                        "<tr>\n" +
                                            "<td>City:</td><td>" + city + "</td>\n" +
                                        "</tr>\n" +
                                        "<tr>\n" +
                                            "<td>Address:</td><td>" + address + "</td>\n" +
                                        "</tr>\n" +
                                  "</table>");
                    %>
                </div>
            </div>
        </div>
            <div class="row decor_bg">
                <div class="col-md-6 col-md-offset-3">
                    <div class="panel panel-info">
                        <div class="panel-heading">Order Details</div>
                        <%  //Query to set order status to Confirmed on user's orders where order status was 'Added to Cart'
                        String successQuery = "SELECT itemname,price,quantity,item_id FROM `orders`,`items` WHERE order_status = 'Added To Cart' AND user_id = (SELECT id FROM `users` WHERE name = ?) AND id = item_id";
                        ResultSet itemRS = null;
                        int itemNo = 0;
                        String itemName = null;
                        String price = null;
                        String quantity = null;
                        String itemID;
                        float total = 0;
                        try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, username, password);
                        PreparedStatement pt = con.prepareStatement(successQuery);
                        pt.setString(1, name);
                        itemRS = pt.executeQuery();
                            if(itemRS.isBeforeFirst()) {
                                out.print("<table class=\"table table-striped\">\n" +
                                    "<form method=\"post\" action=\"cart\">\n" +
                                    "<thead>\n" +
                                        "<tr>\n" +
                                            "<th>Item Number</th>\n" +
                                            "<th>Item Name</th>\n" +
                                            "<th>Price</th>\n" +
                                            "<th>Quantity</th>\n" +
                                            "<th></th>\n" + "" +
                                        "</tr>\n" +
                                    "</thead>\n" +
                                    "<tbody>");
                                while (itemRS.next()) {
                                    itemNo++;
                                    itemName = itemRS.getString("itemname");
                                    price = itemRS.getString("price");
                                    quantity = itemRS.getString("quantity");
                                    itemID = itemRS.getString("item_id");
                                    total = total + Float.parseFloat((itemRS.getString("price")));

                                    out.print("<tr>\n" +
                                                "<td>" + itemNo + "</td><td>" + itemName + "</td><td>" + price + "</td><td>" + quantity + "</td>\n" + "<td><button class=\"btn btn-primary\" type=\"submit\" name=\"delete\" value=\"" + itemID + "\">Delete</button></td>" +
                                              "</tr>");
                                }
                                out.print(    "<tr>\n" +
                                                "<td></td><td>Total</td><td>Rs" + total + "</td><td><a href='success.jsp' class='btn btn-primary'>Confirm Order</a></td><td></td>\n" +
                                              "</tr>");
                                out.print("</tbody>\n" +
                                        "</form>\n" +
                                        "</table>");
                            } else {
                                out.print("<h2>No Items in Cart</h2>");
                            }
                        }
                        catch (Exception e){
                        e.printStackTrace();
                        }
                        %>

                </div>
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