package com.example.myapp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/add_new_teacher")
public class AddNewTeacher extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        int teacher_id = -1;
        try {
            teacher_id = DBConnector.addNewTeacher(name, username, password);
        } catch (SQLException ex) {
            Logger.getLogger(AddNewTeacher.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (teacher_id > 0) {
            response.sendRedirect("admin.jsp?message=New Teacher added with ID: " + teacher_id);
        } else {
            response.sendRedirect("admin.jsp?message=Action Failed!");

        }
    }
}
