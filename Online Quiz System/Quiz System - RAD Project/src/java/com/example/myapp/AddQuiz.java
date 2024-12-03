package com.example.myapp;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/addquiz")
public class AddQuiz extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        java.util.Enumeration<String> paramNames = request.getParameterNames();

        int subject_id = Integer.parseInt(request.getParameter("subject"));
        String quizName = request.getParameter("quizName");
        String deadline = request.getParameter("deadline");
        int duration = Integer.parseInt(request.getParameter("duration"));
        String description = request.getParameter("description");

        int quiz_id = -1;
        try {
            quiz_id = DBConnector.addNewQuiz(quizName, description, subject_id, deadline, duration);
        } catch (SQLException ex) {
            Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (quiz_id > 0) {
            while (paramNames.hasMoreElements()) {
                String key = paramNames.nextElement();
                if (key.startsWith("question")) {
                    String question = request.getParameter(key);
                    int question_id = -1;
                    try {
                        question_id = DBConnector.addNewQuestion(question.trim(), quiz_id);
                    } catch (SQLException ex) {
                        Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    if (question_id > 0) {
                        int questionNumber = Integer.parseInt(key.replace("question", ""));
                        String[] answers = request.getParameter("answers" + questionNumber).split(",");
                        int correctAnswer = Integer.parseInt(request.getParameter("correctAnswer" + questionNumber).trim());
                        try {
                            DBConnector.addNewAnswer(question_id, answers[0].trim(), answers[1].trim(), answers[2].trim(), answers[3].trim(), correctAnswer);
                        } catch (SQLException ex) {
                            Logger.getLogger(AddQuiz.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
        }
        response.sendRedirect("teacher_home.jsp");
    }
}
