
package com.example.myapp;


import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class SignIn extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String role = request.getParameter("role");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username.equals("admin") && password.equals("admin")) {
            response.sendRedirect("admin.jsp");
        } else {
            int id = 0;
            try {
                DBConnector dBConnector = new DBConnector();
                id = dBConnector.validateUser(username, password, role);
            } catch (SQLException e) {
            }
            if (id > 0) {
                HttpSession session = request.getSession();
                session.setAttribute("id", id);
                session.setAttribute("role", role);
                response.sendRedirect(role + "_home.jsp");
            } else {
                response.sendRedirect("signin.jsp?error=Invalid credentials. Please try again.");
            }
        }

    }
}
