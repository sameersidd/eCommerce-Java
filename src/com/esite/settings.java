/*
* This servlet is used to DELETE or UPDATE PASSWORD of accounts
* based on what they selected on the settings.jsp page
* */
package com.esite;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@javax.servlet.annotation.WebServlet(name = "settings", urlPatterns = ("/settings"))
public class settings extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        DAO dao = new DAO();
        HttpSession session = request.getSession();
        String name = (String)session.getAttribute("name");
        String formValue = request.getParameter("button");

        // if Security Change form was clicked
        if(formValue.equals("SecurityChange")) {
            String action = request.getParameter("action"); //Check which action user has selected
            String oPassword = request.getParameter("old-password"); //Gets the rest of the form details
            String cPassword = request.getParameter("password1");
            String password = request.getParameter("password");

            //Deletes the account if delete is checked
            if (action.equals("delete")) {
                dao.deleteAccount(name, oPassword);
                session.removeAttribute("name");
                session.invalidate();
                response.sendRedirect("index.jsp");
            }

            //Updates the password if update is checked
            else if (action.equals("update")) {
                if (cPassword.equals(password)) {
                    dao.changePassword(name, password, oPassword);
                    session.setAttribute("profileChange", "password");
                    response.sendRedirect("setting.jsp");
                } else {
                    session.setAttribute("profileChange", "newPassNotSame");
                    response.sendRedirect("settings.jsp");
                }
            }
        }


        //if Account Change form was clicked
        else if (formValue.equals("AccountChange")){
            String Parameter;
            String newName = request.getParameter("new-name");
            String email = request.getParameter("new-email");
            String contact = request.getParameter("new-contact");
            String city = request.getParameter("new-city");
            String address = request.getParameter("new-address");

            if(!(newName.isEmpty())) {Parameter = "name"; dao.changeAccount(name,Parameter,newName); session.setAttribute("name",newName); }
            else if (!(email.isEmpty())) { Parameter = "email"; dao.changeAccount(name,Parameter,email); }      //Based on which field is NOT EMPTY!!
            else if (!(city.isEmpty())) {Parameter = "city"; dao.changeAccount(name,Parameter,city);}           //The column name is selected
            else if (!(address.isEmpty())) {Parameter = "address"; dao.changeAccount(name,Parameter,address);}  // And sent for process
            else if (!(contact.isEmpty())) {
                if (contact.length() != 10) {
                    session.setAttribute("profileChange", "InvalidContact");                             //This section for contact
                } else {                                                                                        //This checks whether contact length
                    Parameter = "contact";                                                                      //is exactly 10 digit number
                    dao.changeAccount(name, Parameter, contact);
                }
            }
            if(!(session.getAttribute("profileChange").equals("InvalidContact"))){
            session.setAttribute("profileChange","AccountChange");    }                                   //Changing name ALSO changes name in session!
            response.sendRedirect("settings.jsp");
        }
    }
}