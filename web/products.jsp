<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Products | Life Style Store</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
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
                    <%
                    if(session.getAttribute("name")==null) {
                        out.println("<ul class=\"nav navbar-nav navbar-right\" >" +
                                "<li ><a href = \"signup.jsp\" ><span class=\"glyphicon glyphicon-user\" ></span > Sign Up</a >" +
                                "</li ><li ><a href = \"login.jsp\" ><span class=\"glyphicon glyphicon-log-in\" ></span > Login </a ></li >" +
                                "</ul >");
                    }
                    else
                    {
                        out.println("<ul class=\"nav navbar-nav navbar-right\" >" +
                            "<li ><a href = \"settings.jsp\" ><span class=\"glyphicon glyphicon-user\" ></span > Profile </a >" +
                            "</li ><li ><a href = \"cart.jsp\" ><span class=\"glyphicon glyphicon-shopping-cart\" ></span > Cart </a ></li >" +
                            "<li><a href = \"logout\"><span class = \"glyphicon glyphicon-log-in\"></span> Logout</a></li>" +
                            "</ul >");
                    }
                    %>
                </div>
            </div>
        </div>

        <div class="container" id="content">

            <!-- Jumbotron Header -->
            <div class="jumbotron home-spacer" id="products-jumbotron">
                <h1>Welcome to our Lifestyle Store!</h1>
                <p>We have the best cameras, watches and shirts for you. No need to hunt around, we have all in one place.</p>

            </div>
            <hr>
<%-- Please remove Auto formatting to not ruin below code --%>
<%                  //Query to run through for available items whose quantity > 0
                    String query = "SELECT * FROM `items`,`items_merch` WHERE stock > 0 AND items.id = item_id;";
                    String url = "jdbc:mysql://localhost:3306/lifestylestore";
                    String username = "estore";
                    String password = "1234";
                    ResultSet rs;
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, username, password);
                        PreparedStatement pt = con.prepareStatement(query);
                        rs = pt.executeQuery();
                        while(rs.next()) {
                            int itemID = rs.getInt("items.id");
                            String itemName = rs.getString("itemname");
                            String price = rs.getString("price");
                            String img = rs.getString("image");
                            int quantity = rs.getInt("stock");
                            String merchant = rs.getString("merch_name");
                                                                                                                        //Printing a Item Block dynamically using the above data
                            out.println("<div class=\"col-md-3 col-sm-6 home-feature\">" +
                                             "<div class=\"thumbnail\">" + "<img src=\"img/" + img + "\" alt=\"" + itemName + "\">" +
                                                "<div class=\"caption\">" +
                                                    "<a href=\"item.jsp?itemID=" + itemID + "\">" +
                                                   "<h3>" + itemName + "</h3></a>" +
                                                    "<p>Price: Rs. " + price + "</p>" +
                                                    "<p>Quantity: " + quantity + "</p>");                               //FIRST part of Item details stop here
if(session.getAttribute("name")==null){out.print(   "<p><a href=\"login.jsp\" role=\"button\" class=\"btn btn-primary btn-block\">Please Login to purchase</a></p>");} else {
out.print(                                          "<form action=\"cart\" autocomplete=\"off\" method=\"post\">\n" +    //Above button takes you to LOGIN page when NO USER IS LOGGED IN
/* THIS IS NOT A MESS*/                                 "<input type=\"hidden\" name = \"itemID\" value = \"" + itemID +"\">\n" +
/* THIS SECTION IS */                                       "<label for=\"quantity\">Quantity: </label>\n" +
/* EXPLAINED TO THE RIGHT */                                "<select name=\"quantity\" id=\"quantity\">\n");            //SECOND part of checking for session stop here
for(int q = 1; q<=quantity; q++){out.println(                 "<option value=\"" + q + "\">" + q + "</option>\n");}     //This prints a dynamic list for quantity DropDown-list
out.print(                                                  "</select>\n" +
                                                        "<p>Sold by: " + merchant + "</p>" +
                                                    "<button type=\"submit\" class=\"btn btn-primary btn-block\" name=\"add\" value=\"add\">Add to Cart</button>\n" +
                                                    "</form>");}                                                        //THIRD part of a Else block for a dynamic quantity list
out.println(                                    "</div>" +                                                              //and Add to Item action stops here
                                             "</div>" +                                                                 //This formatting is done to make HTML output understandable
                                         "</div>");
                        }
                    }
                    catch (Exception e) {
                        e.printStackTrace();
                    }
                    %>
            <%--<div class="row text-center" id="cameras">
              <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/5.jpg" alt="">
                        <div class="caption">
                            <h3>Cannon EOS </h3>
                            <p>Price: Rs. 36000.00 </p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/2.jpg" alt="">
                        <div class="caption">
                            <h3>Nikon EOS </h3>
                            <p>Price: Rs. 40,000.00 </p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/3.jpg" alt="">
                        <div class="caption">
                            <h3>Sony DSLR</h3>
                            <p>Price: Rs. 50000.00</p>
                            <p>Quantity: </p>
                            <form action="add" autocomplete="off" method="post">
                                <input type="hidden" name = "itemID" value = "ID">
                                <label for="quantity">Quantity: </label>
                                    <select name="quantity" id="quantity">
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                        <option value="4">4</option>
                                    </select>
                                <button type="submit" class="btn btn-primary btn-block" name="action">Add to Item</button>
                            </form>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/4.jpg" alt="">
                        <div class="caption">
                            <h3>Olympus DSLR</h3>
                            <p>Price: Rs. 50000.00</p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row text-center" id="watches">
                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/18.jpg" alt="">
                        <div class="caption">
                            <h3>Titan Model #301 </h3>
                            <p>Price: Rs. 13000.00 </p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/19.jpg" alt="">
                        <div class="caption">
                            <h3>Titan Model #201</h3>
                            <p>Price: Rs. 3000.00 </p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/20.jpg" alt="">
                        <div class="caption">
                            <h3>HMT Milan</h3>
                            <p>Price: Rs. 8000.00 </p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/21.jpg" alt="">
                        <div class="caption">
                            <h3>Faber Luba #111 </h3>
                            <p>Price: Rs. 18000.00 </p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row text-center" id="shirts">
                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/22.jpg" alt="">
                        <div class="caption">
                            <h3>H&W </h3>
                            <p>Price: Rs. 800.00 </p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/23.jpg" alt="">
                        <div class="caption">
                            <h3>Luis Phil</h3>
                            <p>Price: Rs. 1000.00</p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/24.jpg" alt="">
                        <div class="caption">
                            <h3>John Zok</h3>
                            <p>Price: Rs. 1500.00</p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3 col-sm-6 home-feature">
                    <div class="thumbnail">
                        <img src="img/25.jpg" alt="">
                        <div class="caption">
                            <h3>Jhalsani</h3>
                            <p>Price Rs. 1300.00</p>
                            <p><a href="login.jsp" role="button" class="btn btn-primary btn-block">Add to Item</a></p>
                        </div>
                    </div>
                </div>
            </div>--%>
            <hr>
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
