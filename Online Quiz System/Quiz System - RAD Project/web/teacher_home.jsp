
<%@page import="java.util.List"%>
<%@page import="com.example.myapp.DBConnector" %>
<%@page import="com.example.myapp.Teacher" %>
<%@page import="com.example.myapp.Quiz" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Teacher Home Page - Online Quiz System</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
            }

            header {
                display: flex;
                align-items: center;
                background-color:  #f2f2f2;
                height: 70px;
                padding: 0 20px;
            }

            .logo {
                height: 50px;
                margin-right: 10px;
            }

            .small-title {
                font-size: 24px;
                color: #000;
                font-weight: bold;
            }

            h1 {
                color: #fff;
                font-size: 28px;
            }

            .profile-pic {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 15px;
                background-color: #fff;
                width: 100%;
                margin-bottom: 40px;
            }

            .profile-pic img {
                max-width: 200px;
                height: auto;
                border-radius: 50%;
                margin-bottom: 15px;
            }

            .welcome-text {
                color: #000;
                font-size: 22px;
                font-weight: bold;
                margin: 0;
            }

            .profile-details {
                color: #000;
                font-size: 20px;
                margin: 0;
            }

            .container {
                max-width: 1000px;
                margin: 0 auto;
                padding: 20px;
            }

            .btn {
                padding: 12px 30px;
                font-size: 24px;
                background-color: #0047AB; /* Blue */
                color: #fff;
                border: none;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                margin-top: 40px;
                border-radius: 5px;
                box-shadow: 0 3px 5px rgba(0, 0, 0, 0.2);
            }

            .btn:hover {
                background-color: #002E6D;
            }

            table {
                width: 100%;
                margin-top: 40px;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 10px;
                text-align: center;
                color: #333;
                font-weight: bold;
            }

            th {
                background-color: #444;
                color: #fff;
            }

            .ongoing-quizzes,
            .completed-quizzes {
                color: #333;
                font-weight: bold;
                font-size: 24px;
                margin: 20px 0 10px;
            }

            .view-results-btn {
                display: inline-block;
                padding: 8px 16px;
                font-size: 18px;
                background-color: #0047AB; 
                color: #fff;
                border: none;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .view-results-btn:hover {
                background-color: #002E6D; 
            }

            .bt_signout {
                margin-left: auto;
                padding: 8px 16px;
                font-size: 18px;
                background-color: #fff;
                color: #000;
                border: none;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }

            .bt_signout:hover {
                background-color: #f5f5f5;
            }
        </style>
    </head>
    <body>
        <header>
            <img src="ImagesFolder/logoo2.png" alt="Logo" class="logo">
            <h1 class="small-title">Scholar's Hub</h1>
            <a href="signin.jsp" class="bt_signout">Sign Out</a>
        </header>

        <div class="container">
            <div class="profile-pic">
                <img src="ImagesFolder/T_PP.jpeg" alt="ProPic">
                <%
                    Teacher teacher = null;
                    int id = Integer.parseInt(session.getAttribute("id").toString());

                    DBConnector dBConnection = new DBConnector();
                    teacher = dBConnection.getTeacherById(id);
                %>
                <div>
                    <p class="welcome-text">Welcome, <%= teacher.getName()%></p>
                    <p class="profile-details">ID: <%= teacher.getUsername()%></p>
                </div>
            </div>

            <a href="addNewQuiz.jsp" class="btn">Add New Quiz</a>

            <table>
                <caption class="ongoing-quizzes">Ongoing Quizzes</caption>
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Quiz Name</th>
                        <th>Deadline</th>
                        <th>Duration</th>
                        <th>Marks</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Quiz> ongoing_quizzes = dBConnection.getTeacherOngoingQuizzes(id);

                        for (Quiz quiz : ongoing_quizzes) {
                    %>
                    <tr>
                        <td><%= quiz.getSubject()%></td>
                        <td><%= quiz.getName()%></td>
                        <td><%= quiz.getDeadline()%></td>
                        <td><%= quiz.getDuration()%> minutes</td>
                        <td><a href="quiz_results.jsp?id=<%= quiz.getId()%>" class="view-results-btn">View Results</a></td>
                    </tr>
                    <%
                        }
                    %>

                </tbody>
            </table>

            <table>
                <caption class="completed-quizzes">Completed Quizzes</caption>
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Quiz Name</th>
                        <th>Deadline</th>
                        <th>Status</th>
                        <th>Marks</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Quiz> completed_quizzes = dBConnection.getTeacherCompltedQuizzes(id);

                        for (Quiz quiz : completed_quizzes) {
                    %>
                    <tr>
                        <td><%= quiz.getSubject()%></td>
                        <td><%= quiz.getName()%></td>
                        <td><%= quiz.getDeadline()%></td>
                        <td><%= quiz.getDuration()%> minutes</td>
                        <td><a href="quiz_results.jsp?id=<%= quiz.getId()%>" class="view-results-btn">View Results</a></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </body>
</html>
