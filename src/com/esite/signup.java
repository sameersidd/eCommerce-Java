/*
 *This servlet handles the User registration process
 * */
package com.esite;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@javax.servlet.annotation.WebServlet(name = "signup", urlPatterns = "/signup")
public class signup extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DAO dao = new DAO();
        String name = request.getParameter("name");
        String email = request.getParameter("e-mail");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");
        String city = request.getParameter("city");
        String address = request.getParameter("address");
        if(contact.length()!=10){
            request.getSession().setAttribute("ProfileSignup","InvalidContact");
            response.sendRedirect("settings.jsp");
        } else {
            dao.signUp(name, email, password, contact, city, address);
            HttpSession session = request.getSession();
            session.setAttribute("name", name);
            response.sendRedirect("index.jsp");
        }
    }
}
