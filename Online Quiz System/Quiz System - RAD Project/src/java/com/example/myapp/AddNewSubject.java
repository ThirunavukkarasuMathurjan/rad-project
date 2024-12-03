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

@WebServlet("/add_new_subject")
public class AddNewSubject extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        int teacher_id = Integer.parseInt(request.getParameter("teacher_id"));

        int subject_id = -1;
        try {
            subject_id = DBConnector.addNewSubject(name, teacher_id);
        } catch (SQLException ex) {
            Logger.getLogger(AddNewSubject.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (subject_id > 0) {
            response.sendRedirect("admin.jsp?message=New Subject added with ID: " + subject_id);
        } else {
            response.sendRedirect("admin.jsp?message=Action Failed!");

        }
    }
}
