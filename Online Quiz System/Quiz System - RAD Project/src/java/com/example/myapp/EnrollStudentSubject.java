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

@WebServlet("/enroll_student_subject")
public class EnrollStudentSubject extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int student_id = Integer.parseInt(request.getParameter("student_id"));
        int subject_id = Integer.parseInt(request.getParameter("subject_id"));

        int student_subject_id = -1;
        try {
            student_subject_id = DBConnector.enrollStudentSubject(student_id, subject_id);
        } catch (SQLException ex) {
            Logger.getLogger(EnrollStudentSubject.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (student_subject_id > 0) {
            response.sendRedirect("admin.jsp?message=Enrolled with ID: " + student_subject_id);
        } else {
            response.sendRedirect("admin.jsp?message=Action Failed!");

        }
    }
}
