/*
 *This servlet is used to LOGOUT w/o affecting any accounts
 * */
package com.esite;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@javax.servlet.annotation.WebServlet(name = "logout", urlPatterns = "/logout")
public class logout extends javax.servlet.http.HttpServlet {
    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("name");
        session.removeAttribute("login");
        session.removeAttribute("cart");
        session.removeAttribute("profileChange");
        session.removeAttribute("ConfirmCart");
        session.invalidate();   //Destroys session
        response.sendRedirect("index.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        doPost(request,response);
    }
}
