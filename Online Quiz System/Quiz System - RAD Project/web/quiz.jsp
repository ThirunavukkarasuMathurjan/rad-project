<%@page import="com.example.myapp.Question"%>
<%@page import="java.util.List"%>
<%@page import="com.example.myapp.Quiz"%>
<%@page import="com.example.myapp.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Page</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fff;
                text-align: left;
                margin: 0;
                padding: 0;
            }
            body {

                background-size: cover;
                background-position: center;
                font-family: Arial, sans-serif;
            }
            header {
                display: flex;
                align-items: center;
                background-color: #f2f2f2;
                height: 70px;
                padding: 0 20px;
            }

            header img {
                height: 50px;
                margin-right: 5px; 
            }
            small-title {
                font-size: 24px;
                margin-right: 5px; 

            }

            .quiz-container {
                width: 80%;
                margin: 0 auto;
                background-color: #f0f0f0;
                padding: 20px;
                border-radius: 20px;
            }
            h1 {
                text-align: center;
                color: #000;
                font-size: 1.5em;
            }

            h2, h3 {
                margin-bottom: 20px;

            }

            .question {
                margin-bottom: 20px;
                background-color: #fff;
                color: #000;
                padding: 20px;
                border-radius: 5px;
            }

            .question-number {
                font-weight: bold;
                font-size: 20px;
                margin-top: 0;
            }

            .question-text {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .answer-option {
                display: flex;
                align-items: center;
                justify-content: flex-start;
                margin-bottom: 10px;
            }

            .answer-option input[type="radio"] {
                margin-right: 10px;
            }

            .answer-option label {
                background-color: #e0eaf5;
                padding: 10px;
                border-radius: 5px;
            }

            .btn-submit-container {
                display: flex;
                justify-content: center;
                margin-top: 40px;
            }

            .btn-submit {
                display:flex;
                justify-content: center;
                padding: 8px 16px;
                background-color: #002D62 ;
                color: #fff;
                border: #999494;
                cursor: pointer;
                text-decoration: none;
                font-size: 20px;
                font-weight: bold;
                margin-top: 15px;

            }

            .btn-submit:hover {
                background-color: #00308F;
            }

            .bt_signout {
                margin-left: auto;
                padding: 8px 16px;
                background-color: #fff;
                color: #000;
                border: none;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
            }

            .bt_signout:hover {
                background-color: #f5f5f5;
            }

        </style>
    </head>
    <body>
        <header>
            <img src="ImagesFolder/logoo2.png" alt="Logo">
            <h1 class="small-title">Scholar's Hub</h1>
            <a href="signin.jsp" class="bt_signout">Sign Out</a>
        </header><br><br><br><br>

        <div class="quiz-container">
            <%
                
                int quiz_id = Integer.parseInt(request.getParameter("quiz_id"));

                session.setAttribute("quiz_id", quiz_id);

                DBConnector dBConnection = new DBConnector();
                Quiz quiz = dBConnection.getQuizById(quiz_id);
            %>
            <h2 style="text-align: center; font-size: 24px; font-weight: bold; color: #00308F;">Subject: <%= quiz.getSubject()%></h2>
            <h3 style="text-align: center; font-size: 18px; font-weight: bold; color:#002D62;">Quiz Name: <%= quiz.getName()%></h3>
            <form id="quiz-form" action="submit_quiz" method="post">
                <%
                    List<Question> questions = dBConnection.getQuizQuestions(quiz_id);
                    int questionCounter = 1;

                    for (Question question : questions) {
                %>
                <div class="question">
                    <p class="question-number">Question <%= questionCounter%>:</p>
                    <p class="question-text"><%= question.getQuestion()%></p>
                    <div class="answer-option">
                        <input type="radio" name="<%= question.getId()%>" id="q<%= questionCounter%>a" value="1" required>
                        <label for="q<%= questionCounter%>a"><%= question.getAnswer1()%></label>
                    </div>
                    <div class="answer-option">
                        <input type="radio" name="<%= question.getId()%>" id="q<%= questionCounter%>b" value="2" required> 
                        <label for="q<%= questionCounter%>b"><%= question.getAnswer2()%></label>
                    </div>
                    <div class="answer-option">
                        <input type="radio" name="<%= question.getId()%>" id="q<%= questionCounter%>c" value="3" required>
                        <label for="q<%= questionCounter%>c"><%= question.getAnswer3()%></label>
                    </div>
                    <div class="answer-option">
                        <input type="radio" name="<%= question.getId()%>" id="q<%= questionCounter%>d" value="4" required>
                        <label for="q<%= questionCounter%>d"><%= question.getAnswer4()%></label>
                    </div>
                </div>
                <%
                        questionCounter++;
                    }
                %>
                <input type="submit" value="Submit">

            </form>
        </div>
    </body>

</html>

