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
<%                  //Query to run through for available items whose quantity > 0
                    String itemID = request.getParameter("itemID");
                    String query = "SELECT * from `items`,`item_description`,`items_merch` WHERE items.id = ? AND item_description.item_id = items.id AND items_merch.item_id = items.id;";
                    String url = "jdbc:mysql://localhost:3306/lifestylestore";
                    String username = "estore";
                    String password = "1234";
                    ResultSet rs;
                    try{
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, username, password);
                        PreparedStatement pt = con.prepareStatement(query);
                        pt.setString(1,itemID);
                        rs = pt.executeQuery();
                        rs.next();
                            String itemName = rs.getString("itemname");
                            String price = rs.getString("price");
                            String img = rs.getString("image");
                            int quantity = rs.getInt("stock");
                            String merchant = rs.getString("merch_name");
                            String desc = rs.getString("description");
                                    out.println("<div class=\"col-md-3 col-sm-6 home-feature\">" +
                                                    "<div class=\"thumbnail\">" + "<img src=\"img/" + img + "\" alt=\"" + itemName + "\">" +
                                                    "<div class=\"caption\">" +
                                                    "<h3>" + itemName + "</h3>" +
                                                    "<p>Price: Rs. " + price + "</p>" +
                                                    "<p>Quantity: " + quantity + "</p>" +
                                                    "<p>Sold by: " + merchant + "</p>");                                //FIRST part of Item details stop here
if(session.getAttribute("name")==null){out.print(   "<p><a href=\"login.jsp\" role=\"button\" class=\"btn btn-primary btn-block\">Please Login to purchase</a></p>");} else {
out.print(                                          "<form action=\"cart\" autocomplete=\"off\" method=\"post\">\n" +    //Above button takes you to LOGIN page when NO USER IS LOGGED IN
 /* THIS IS NOT A MESS*/                                 "<input type=\"hidden\" name = \"itemID\" value = \"" + itemID +"\">\n" +
/* THIS SECTION IS */                                       "<label for=\"quantity\">Quantity: </label>\n" +
/* EXPLAINED TO THE RIGHT */                                "<select name=\"quantity\" id=\"quantity\">\n");            //SECOND part of checking for session stop here
for(int q = 1; q<=quantity; q++){out.println(                 "<option value=\"" + q + "\">" + q + "</option>\n");}     //This prints a dynamic list for quantity DropDown-list
out.print(                                                  "</select>\n" +
                                                        "<button type=\"submit\" class=\"btn btn-primary btn-block\" name=\"add\" value=\"add\">Add to Cart</button>\n" +
                                                    "</form>"); }                                                        //THIRD part of a Else block for a dynamic quantity list
out.println(                                    "</div>" +                                                              //and Add to Item action stops here
                                             "</div>" +                                                                 //This formatting is done to make HTML output understandable
                                            "</div>");
out.print(                              "<div class=\"col-lg-9 col-md-3\">\n" +
                                            "<div class=\"panel panel-default\">\n" +
                                                "<div class=\"panel-heading\">Product Description</div>\n" +
                                            "<div style=\"width: 90%; margin: 2% 5% 2% 5%;\">  \n" +
                                            "<p>" + desc + "</p> \n" +
                                            "</div>\n" +
                                            "</div>\n" +
                                            "</div>\n" +
                                        "</div>");
        }
    catch (Exception e) {
        e.printStackTrace();
    }
            %>
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