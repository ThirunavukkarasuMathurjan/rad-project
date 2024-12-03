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

@WebServlet("/add_new_student")
public class AddNewStudent extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        int student_id = -1;
        try {
            student_id = DBConnector.addNewStudent(name, username, password);
        } catch (SQLException ex) {
            Logger.getLogger(AddNewStudent.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (student_id > 0) {
            response.sendRedirect("admin.jsp?message=New Student added with ID: " + student_id);
        } else {
            response.sendRedirect("admin.jsp?message=Action Failed!");

        }
    }
}
