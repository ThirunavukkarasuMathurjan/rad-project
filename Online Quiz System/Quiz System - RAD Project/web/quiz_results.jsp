
<%@page import="com.example.myapp.Result"%>
<%@page import="java.util.List"%>
<%@page import="com.example.myapp.Quiz"%>
<%@page import="com.example.myapp.DBConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">

        <title>Quiz Results</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-size: cover;
                margin: 0;
                padding: 0;
                background-color: #f2f2f2; 
            }

            .container {
                background-color: #fff; 
                border-radius: 10px; 
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
                padding: 20px;
                margin-top: 30px;
            }

            header {
                display: flex;
                align-items: center;
                background-color:  #f2f2f2;
                height: 70px;
                padding: 0 20px;
            }

            .small-title {
                font-size: 24px;
                margin-right: 10px;
                color: #000;
                font-weight: bold;
            }

            header img {
                height: 50px;
                margin-right: 10px;
            }

            h1 {
                color: #333;
                font-size: 28px;
            }

            .profile-pic {
                align-items: center;
                padding: 15px;
                background-color: #000;
                color: #fff;
                width: 100%;
            }

            .profile-pic p {
                font-weight: bold;
                font-size: 24px;
                margin: 5px 0;
            }

            table {
                width: 100%; 
                margin: 20px 0;
                border-collapse: collapse;
            }

            th, td {
                padding: 12px;
                text-align: center;
                color: #000;
                font-weight: bold;
            }

            th {
                background-color: #f2f2f2; 
            }

            .btn {
                padding: 12px 24px; 
                font-size: 24px;
                background-color: #fff;
                color: #000;
                border: none;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                margin-top: 20px;
                margin-bottom: 10px;
            }

            .btn:hover {
                background-color: #f5f5f5;
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
            }

            .ongoing-quizzes,
            .completed-quizzes {
                color: #fff;
                font-weight: bold;
                font-size: 20px;
                margin-bottom: 10px;
            }

            .black-box {
                background-color: #f2f2f2; 
                color: #000;
                padding: 20px;
                margin-bottom: 20px;
                border-radius: 5px; 
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3); 
            }

            .black-box p {
                font-size: 18px;
                font-weight: bold;
                margin: 5px 0;
                margin-top: 10px;
            }


        </style>
    </head>

    <body>
        <header>
            <img src="ImagesFolder/logoo2.png" alt="Logo">
            <h1 class="small-title">Scholar's Hub</h1>
            <a href="signin.jsp" class="bt_signout">Sign Out</a>
        </header>

        <div class="container">
            <div class="students_marks_container">
                <div class="container">
                    <div class="students_marks_container">
                        <div class="text-center">
                            <h1 style="color: #333;font-size: 30px;padding: 2px;">Quiz Results</h1>
                        </div>
                    </div>
                </div>
            </div>

            <div class="quiz-details">
                <%
                    Quiz quiz = null;
                    int quiz_id = Integer.parseInt(request.getParameter("id"));

                    DBConnector dBConnection = new DBConnector();
                    quiz = dBConnection.getQuizById(quiz_id);
                %>
                <div class="black-box">
                    <p>Subject: <%= quiz.getSubject()%></p>
                    <p>Quiz Name: <%= quiz.getName()%></p>
                </div>

                <div class="table-container">
                    <table class="table table-hover table-striped">
                        <thead class="thead-dark top-0 position-sticky h-45">
                            <tr>
                                <th scope="col">No</th>
                                <th scope="col">Reg.No</th>
                                <th scope="col">Name</th>
                                <th scope="col">Completed Date</th>
                                <th scope="col"> Score</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Result> results = dBConnection.getQuizResults(quiz_id);
                                for (Result result : results) {
                            %>
                            <tr>
                                <td><%= result.getId()%></td>
                                <td><%= result.getStudentUsername()%></td>
                                <td><%= result.getStudentName()%></td>
                                <td><%= result.getCompletedDate()%></td>
                                <td><%= result.getScore()%></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    </body>

</html>

