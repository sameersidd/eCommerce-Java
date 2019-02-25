/*
 *This servlet handles the login process
 * */
package com.esite;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@javax.servlet.annotation.WebServlet(name = "login", urlPatterns = "/login")
public class login extends javax.servlet.http.HttpServlet {

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws IOException, ServletException {
            String email = request.getParameter("e-mail");
            String pass = request.getParameter("password");
            HttpSession session = request.getSession();
            DAO dao = new DAO();
            /*String stmt = dao.login(email,pass);
            PrintWriter out = response.getWriter();
            out.print(stmt);*/
            if(dao.login(email,pass)){
                String name = dao.getName(email, pass);
                session.setAttribute("login","Successful");
                session.setAttribute("cart",null);
                session.setAttribute("name", name);
                response.sendRedirect("index.jsp");
            }
            else {
                session.setAttribute("login","Error");
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request,response);
            }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doPost(request,response);
    }
}
