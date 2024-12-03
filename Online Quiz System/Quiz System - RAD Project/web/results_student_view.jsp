
<%@page import="com.example.myapp.Quiz"%>
<%@page import="com.example.myapp.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quiz Result</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-size: cover;
                margin: 0;
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
                height: 50px;
                margin-right: 5px;
            }

            h1 {
                color: #000;
                font-size: 30px;
                padding: 15px;
                margin: 0;
            }

            .small-title {
                font-size: 24px;
                margin-right: 5px;
                font-weight: bold;
            }

            .score-container {
                margin: 0 auto;
                max-width: 600px;
                width: 80%;
                border-radius: 5px;
                padding: 40px;
                color: #000;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color:#f2f2f2;
                box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.6);
            }

            .score-container h2 {
                font-size: 24px;
                margin-bottom: 10px;
            }

            .score-container p {
                font-size: 18px;
                margin-bottom: 0;
            }

            .btn-review {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 18px;
                margin-top: 20px;
                text-decoration: none;
                transition: background-color 0.3s ease-in-out;
            }

            .btn-review:hover {
                background-color:#00308F;
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
                background-color:  #f5f5f5;
            }
        </style>
    </head>
    <body>
        <header>
            <img src="ImagesFolder/logoo2.png" alt="Logo">
            <h1 class="small-title">Scholar's Hub</h1>
            <a href="signin.jsp" class="bt_signout">Sign Out</a>
        </header>

        <div class="score-container">
            <%
                int quizId = Integer.parseInt(request.getParameter("quiz_id"));
                int score = Integer.parseInt(request.getParameter("score"));

                DBConnector dBConnection = new DBConnector();
                Quiz quiz = dBConnection.getQuizById(quizId);
            %>
            <h2>Subject: <%= quiz.getSubject()%></h2>
            <h5>Quiz Name: <%= quiz.getName()%></h5>
            <p>Your Final score for this quiz is <span id="score"><%= score%>%</span></p>
            <a href="student_home.jsp" class="btn-review">Go To Home</a>
        </div>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>

