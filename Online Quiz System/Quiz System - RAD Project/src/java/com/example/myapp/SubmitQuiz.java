
package com.example.myapp;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/submit_quiz")
public class SubmitQuiz extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Enumeration<String> parameterNames = request.getParameterNames();
        String url = "";
        int correctAnswers = 0;
        int noOfQuestions = 0;
        while (parameterNames.hasMoreElements()) {
            try {
                noOfQuestions++;
                int qid = Integer.parseInt(parameterNames.nextElement());
                int answer = Integer.parseInt(request.getParameter(String.valueOf(qid)));
                DBConnector dBConnector = new DBConnector();
                Question question = dBConnector.getQuestion(qid);
                if (question.getCorrectAnswer() == answer) {
                    correctAnswers++;
                }
            } catch (SQLException ex) {
            }
        }

        HttpSession session = request.getSession();
        int studentId = (int) session.getAttribute("id");
        int quizId = (int) session.getAttribute("quiz_id");
        int score = (int) ((correctAnswers * 100) / noOfQuestions);

        try {
            DBConnector.submitScore(studentId, quizId, score);
        } catch (SQLException ex) {

            Logger.getLogger(SubmitQuiz.class.getName()).log(Level.SEVERE, null, ex);
        }
        response.sendRedirect("results_student_view.jsp?quiz_id=" + quizId + "&score=" + score);
    }
}
