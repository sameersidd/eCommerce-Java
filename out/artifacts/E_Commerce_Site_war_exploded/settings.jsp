<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Settings | Life Style Store</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
                        <li><a href = "cart.jsp"><span class = "glyphicon glyphicon-shopping-cart"></span> Cart </a></li>
                        <li><a href = "logout"><span class = "glyphicon glyphicon-log-in"></span> Logout</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="container-fluid" id="content">
            <div class="row">
            <div class="col-lg-3 col-lg-offset-1">
            <div class="panel panel-info">
                <div class="panel-heading">Profile</div>
                <div class="panel-body">
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
                out.print("<table class=\"table table-striped\" style=\"width:100%\">" +
                    "<tr>" +
                    "<td>Name:</td><td>" + name + "</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td>Email:</td><td>" + email+ "</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td>Contact:</td><td>" + contact + "</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td>City:</td><td>" +city + "</td>" +
                    "</tr>" +
                    "<tr>" +
                    "<td>Address:</td><td>" + address + "</td>" +
                    "</tr>" +
                    "</table>");
                %>
                </div>
            </div>
            </div>
                <div class="col-lg-3" id="account-container">
                    <div class="panel panel-info">
                        <div class="panel-heading">Update Account</div>
                        <div class="panel-body">
                            <%
                                if(session.getAttribute("profileChange")!=null) {
                                    if (session.getAttribute("profileChange").equals("AccountChange")) {
                                        out.print("<div class=\"alert alert-info\" role=\"alert\">\n" + "Account Details Changed\n" + "</div>");
                                    }
                                    else if (session.getAttribute("profileChange").equals("InvalidContact")) {
                                        out.print("<div class=\"alert alert-danger\" role=\"alert\">\n" + "Invalid Contact!\n" + "</div>");
                                    }
                                }
                            %>
                    <form action="settings" method="POST">
                        <div class="form-group"><label for="new-name">Change Name</label>
                            <input type="text" class="form-control" name="new-name" id="new-name"  placeholder="Name">
                        </div>
                        <div class="form-group"><label for="new-email">Change Email</label>
                            <input type="text" class="form-control" name="new-email" id="new-email"  placeholder="Email">
                        </div>
                        <div class="form-group"><label for="new-contact">Change Contact</label>
                            <input type="text" class="form-control" name="new-contact" id="new-contact"  placeholder="Contact">
                        </div>
                        <div class="form-group"><label for="new-city">Change City</label>
                            <input type="text" class="form-control" name="new-city" id="new-city"  placeholder="City">
                        </div>
                        <div class="form-group"><label for="new-address">Change Address</label>
                            <input type="password" class="form-control" name="new-address" id="new-address"  placeholder="Address">
                        </div>
                        <button type="submit" class="btn btn-primary" name="button" value="AccountChange">Submit</button>
                    </form>
                        </div>
                    </div>
                </div>
                    <div class="col-lg-3 col-lg-offset-1" id="settings-container">
                      <div class="panel panel-warning">
                        <div class="panel-heading">Change Password or Account</div>
                           <div class="panel-body">
                               <%
                                   if(session.getAttribute("profileChange")!=null) {
                                       if (session.getAttribute("profileChange").equals("newPassNotSame")) {
                                           out.print("<div class=\"alert alert-warning\" role=\"alert\">\n" + "Password Not Changed!\n" + "</div>");
                                       }
                                   }
                               %>
                     <form action="settings" method="POST">
                        <div class="form-group"><label for="old-password">Enter Current Password</label>
                            <input type="password" class="form-control" name="old-password" id="old-password"  placeholder="Old Password" required>
                        </div>
                        <div class="form-group"><label for="password">Enter New Password</label>
                            <input type="password" class="form-control" name="password" id="password" placeholder="New Password">
                        </div>
                         <%
                             if(session.getAttribute("profileChange")!=null) {
                                 if (session.getAttribute("profileChange").equals("newPassNotSame")) {
                                     out.print("<div class=\"alert alert-warning\" role=\"alert\">\n" + "Re-type Password!\n" + "</div>");
                                 }
                             }
                         %>
                        <div class="form-group"><label for="password1">Re-type New Password</label>
                            <input type="password" class="form-control" name="password1" id="password1"  placeholder="Re-type New Password">
                        </div>
                        <div class="form-group">
                            <label for="updatePass"><input type="radio" value="updatePass" name="action" id="updatePass"> Update Password?</label>
                        </div>
                        <div class="form-group">
                            <label for="delete"><input type="radio" value="delete" name="action" id="delete"> Delete Account?</label>
                        </div>
                        <button type="submit" class="btn btn-danger" name="button" value="SecurityChange" onclick="return confirm('Are you sure?')">Submit</button>
                    </form>
                </div>
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

<%
    if(session.getAttribute("profileChange")!=null) {
        if(session.getAttribute("profileChange").equals("password")){
            out.print("<div class=\"alert alert-info\" role=\"alert\">\n" + "Password Changed!\n" + "</div>");
            session.setAttribute("profileChange",null);
        } else if (session.getAttribute("profileChange").equals("profileChanged")){
            out.print("<div class=\"alert alert-warning\" role=\"alert\">\n" + "Password Not\n" + "</div>");
        }
    }
%>
