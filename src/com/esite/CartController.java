package com.esite;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CartController", urlPatterns = "/cart")
public class CartController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        String item = request.getParameter("itemID");
        String add = request.getParameter("add");
        String delete = request.getParameter("delete");
        Boolean ProcessCart = (Boolean) session.getAttribute("ConfirmCart");
        Cart cart = (Cart) session.getAttribute("cart");

        if(add!=null) {
            if (add.equals("add")) {
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                if (cart == null) {
                    cart = new Cart(name);
                    cart.addToCart(item, quantity);
                    session.setAttribute("cart", cart);
                } else {
                    cart = (Cart) session.getAttribute("cart");
                    cart.addToCart(item, quantity);
                    session.setAttribute("cart", cart);
                }
                session.setAttribute("ConfirmCart", false);
                response.sendRedirect("products.jsp");
            }
        }
        if(delete!=null) {
            DAO dao = new DAO();
            dao.deleteItem(name, delete);
            response.sendRedirect("cart.jsp");
        }


        // FIXME Check this part
        if (ProcessCart != null) {
            if (ProcessCart) {
                DAO dao = new DAO();
                    cart = (Cart) session.getAttribute("cart");
                    String custName = cart.getName();
                    for (int i = 0; i < cart.numberOfItems(); i++) {
                        String itemName = cart.getCart().get(i).getItemID();
                        int itemQuantity = cart.getCart().get(i).getQuantity();
                        dao.confirmItem(custName, itemName, itemQuantity);
                    }
                    cart.emptyCart();
                    //FIXME Here's a big issue
                    session.setAttribute("ConfirmCart", false);
                }
            }
    }
}