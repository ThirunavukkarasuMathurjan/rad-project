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

@WebServlet("/delete_teacher")
public class DeleteTeacher extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int teacher_id = Integer.parseInt(request.getParameter("teacher_id"));
        System.out.println(teacher_id);

        try {
            DBConnector.deleteTeacher(teacher_id);
            response.sendRedirect("admin.jsp");
        } catch (SQLException ex) {
            Logger.getLogger(DeleteTeacher.class.getName()).log(Level.SEVERE, null, ex);
            response.sendRedirect("admin.jsp?message=Action Failed!");
        }
    }
}
