
<%@page import="com.example.myapp.Quiz"%>
<%@page import="com.example.myapp.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Page</title>
        <link rel="stylesheet" href="style.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fff; 
                margin: 0;
                padding: 0;
            }

            header {
                display: flex;
                align-items: center;
                background-color: #f2f2f2; 
                height: 70px;
                padding: 0 20px;
                margin-bottom: 30px;
            }

            header img {
                height: 40px;
                margin-right: 10px;
            }

            .small-title {
                font-size: 24px;
                margin-right: 10px;
                font-weight: bold;
                color: #000000;
            }

            .quiz-info {
                background-color: #f2f2f2; 
                padding: 20px;
                border-radius: 10px;
                max-width: 500px;
                margin: 20px auto 0;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            h1 {
                text-align: center;
                color: #000000;
                font-size: 28px; 
                margin-top: 30px;
                margin-bottom: 20px; 
            }

            .quiz-description {
                margin-bottom: 20px;
            }

            .quiz-description p {
                margin: 8px 0; 
            }

            .quiz-description label {
                font-weight: bold;
                color: #333;
            }

            .quiz-description textarea {
                width: 100%;
                padding: 12px; 
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
                margin-top: 5px;
                resize: none; 
            }

            .quiz_instructions {
                margin-top: 20px;
                padding: 20px; 
                background-color: #f2f2f2;
                border-radius: 10px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                width: 1000px;
                margin: 0 auto;

            }

            .quiz_instructions h2 {
                font-size: 20px;
                margin-bottom: 15px; 
                color: #0047AB; 
            }

            .quiz_instructions p {
                margin: 10px 0; 
                color: #333;
                text-align: justify;

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

            .take-quiz-button {
                display: block;
                width: 100%;
                padding: 12px;
                margin-top: 20px;
                background-color: #0047AB;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
            }

            .take-quiz-button:hover {
                background-color: #002E6D;
            }
        </style>
    </head>
    <body>
        <header>
            <img src="ImagesFolder/logoo2.png" alt="Logo">
            <h1 class="small-title">Scholar's Hub</h1>
            <a href="signin.jsp" class="bt_signout">Sign Out</a>
        </header>

        <h1>Take Your Quiz Now!</h1>

        <div class="quiz_instructions" >
            <h2>Quiz Instructions</h2>
            <p>
                Quizzes are meant to assess individual knowledge and understanding.
                Each participant must attempt the quiz independently without any assistance from others.
                Plagiarism or copying content from external sources is strictly prohibited. 
                All quiz responses must be your original work. Each quiz will have a specified time limit. 
                Please make sure to complete the quiz within the allocated time. Late submissions may not be considered. 
                If the quiz is related to an academic course, academic integrity policies apply. 
                Any violations may result in academic consequences.
            </p>
        </div>

        <div class="quiz-info">
            <div class="quiz-description">
                <%
                    int quizId = Integer.parseInt(request.getParameter("id"));

                    DBConnector dBConnection = new DBConnector();
                    Quiz quiz = dBConnection.getQuizById(quizId);
                %>
                <p><label for="subject">Subject: </label><%= quiz.getSubject()%></p>
                <br>
                <p><label for="quiz-name">Quiz Name: </label><%= quiz.getName()%></p>
                <br>
                <p>
                    <label for="quiz-desc">Quiz Description:</label><br><br>
                    <%= quiz.getDescription()%>
                </p>
            </div>
            <a href="quiz.jsp?quiz_id=<%= quiz.getId()%>" class="take-quiz-button">Take Quiz</a>
        </div>
    </body>
</html>
