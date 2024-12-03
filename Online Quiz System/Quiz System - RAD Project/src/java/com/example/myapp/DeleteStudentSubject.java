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

@WebServlet("/delete_student_subject")
public class DeleteStudentSubject extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int student_subject_id = Integer.parseInt(request.getParameter("student_subject_id"));

        try {
            DBConnector.deleteStudentSubject(student_subject_id);
            response.sendRedirect("admin.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(DeleteStudentSubject.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("admin.jsp?message=Action Failed!");
        }
    }
}
