<%@page import="java.util.List"%>
<%@page import="com.example.myapp.DBConnector" %>
<%@page import="com.example.myapp.Student" %>
<%@page import="com.example.myapp.Quiz"%>
<%@page import="com.example.myapp.Results"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Student Home Page - Online Quiz System</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                text-align: center;
                margin: 0;
                padding: 0;
                background-color: #fff; 
                color: #000; 
            }

            header {
                display: flex;
                align-items: center;
                background-color: #f2f2f2; 
                height: 70px;
                padding: 0 20px;
                margin-bottom: 30px;
            }

            .small-title {
                font-size: 24px;
                margin-right: 10px;
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
                display: flex;
                align-items: center;
                justify-content: center; 
                margin-top: 50px;
                padding: 40px;
                color: #000;
                background-color: #f2f2f2;
                border-radius: 10px;
                max-width: 400px;
                margin: 0 auto;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .profile-pic img {
                max-width: 200px;
                height: auto;
                border-radius: 50%; 
            }

            .profile-info {
                margin-left: 20px;
                text-align: left;
            }

            .profile-info p {
                font-size: 18px;
                color: #333;
                margin-bottom: 8px;
            }

            .profile-info p.name {
                font-size: 24px;
                font-weight: bold;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                background-color: #f2f2f2; 
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            th, td {
                padding: 10px;
                text-align: center;
                color: #333;
                font-weight: bold;
            }

            th {
                background-color: #0047AB;
                color: #fff;
            }

            /* Alternate row colors */
            tbody tr:nth-child(even) {
                background-color: #fff; 
            }

            tbody tr:nth-child(odd) {
                background-color: #f2f2f2; 
            }

            .btn {
                padding: 8px 16px;
                background-color: #0047AB; 
                color: #fff; 
                border: none;
                cursor: pointer;
                text-decoration: none;
                font-weight: bold;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .btn:hover {
                background-color: #002E6D; 
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

            .pending-quizzes,
            .completed-quizzes {
                color: #0047AB;
                font-weight: bold;
                font-size: 24px;
                margin-bottom: 20px;
                margin-top: 30px;
            }
        </style>
    </head>
    <body>
        <header>
            <img src="ImagesFolder/logoo2.png" alt="Logo">
            <h1 class="small-title">Scholar's Hub</h1>
            <a href="signin.jsp" class="bt_signout">Sign Out</a>
        </header>

        <!-- Profile box moved below the header -->
        <div class="profile-pic">
            <img src="ImagesFolder/propic.png" alt="ProPic">
            <%
                Student student = null;
                int id = Integer.parseInt(session.getAttribute("id").toString());

                DBConnector dBConnection = new DBConnector();
                student = dBConnection.getStudentById(id);
            %>
            <div>
            <p class="name">Welcome, <%= student.getName()%></p> 
            <p class="profile-details">ID:  <%= student.getUsername()%></p>
            </div>
        </div>

        <div class="container">
            <table>
                <caption class="pending-quizzes">Pending Quizzes</caption>
                <thead>
                    <tr>
                        <th>Subject</th>
                        <th>Quiz Name</th>
                        <th>Deadline</th>
                        <th>Duration</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Quiz> pending_quizzes = dBConnection.getStudentPendingQuizzes(id);

                        for (Quiz quiz : pending_quizzes) {
                    %>
                    <tr>
                        <td><%= quiz.getSubject()%></td>
                        <td><%= quiz.getName()%></td>
                        <td><%= quiz.getDeadline()%></td>
                        <td><%= quiz.getDuration()%> minutes</td>
                        <td><a href="take_quiz.jsp?id=<%= quiz.getId()%>" class="btn">Take Quiz</a></td>
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
                        <th>Completed Date</th>
                        <th>Score</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Results> completed_quizzes = dBConnection.getStudentCompletedQuizzes(id);

                        for (Results quiz : completed_quizzes) {
                    %>
                    <tr>
                        <td><%= quiz.getSubject()%></td>
                        <td><%= quiz.getQuiz()%></td>
                        <td><%= quiz.getCompleted_date()%></td>
                        <td><%= quiz.getScore()%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>

    </body>
</html>
