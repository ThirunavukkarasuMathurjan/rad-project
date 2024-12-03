<%@page import="java.util.List"%>
<%@page import="com.example.myapp.DBConnector"%>
<%@page import="com.example.myapp.Teacher"%>
<%@page import="com.example.myapp.Subject"%>
<%@page import="com.example.myapp.Student"%>
<%@page import="com.example.myapp.StudentSubject"%>

<html>
    <head>
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
       
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const urlParams = new URLSearchParams(window.location.search);
                const message = urlParams.get('message');
                if (message) {
                    alert(message);
                }
            });
        </script>
        <link rel="icon" href="ImagesFolder/logo2.png">

    </head>
    <body>
        <!--Nav bar-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
            <a class="navbar-brand" href="#">
                <img src="ImagesFolder/logoo2.png" height="30" class="d-inline-block align-top" alt="">
                Scholar's Hub
            </a>

            <div class="navbar-nav ml-auto">
                <a class="nav-link" href="signin.jsp">Sign Out</a>
            </div>
        </nav>

        <%
            DBConnector dBConnection = new DBConnector();
        %>

        <div class="container">
            <h1 class="mt-5">Admin Page</h1>

            <!--Teacher Management-->
            <h2 class="mt-2">Teacher Management</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card"">
                        <div class="card-header">
                            Add New Teacher
                        </div>
                        <div class="card-body">
                            <form action="add_new_teacher" method="post">
                                <div class="form-group">
                                    <label for="teacherName">Name</label>
                                    <input type="text" class="form-control" name="name" placeholder="Enter Name">
                                </div>
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" name="username" placeholder="Enter Username">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="text" class="form-control" name="password" placeholder="Enter Password">
                                </div>
                                <button type="submit" class="btn btn-primary mt-1">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            Teachers
                        </div>
                        <div class="card-body">
                            <div class="table-responsive" style="max-height: 250px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Username</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Teacher> teachers = dBConnection.getAllTeachers();
                                            for (Teacher teacher : teachers) {
                                        %>
                                        <tr>
                                            <td><%= teacher.getId() %></td>
                                            <td><%= teacher.getName() %></td>
                                            <td><%= teacher.getUsername() %></td>
                                            <td><a class="btn btn-danger btn-sm" href="delete_teacher?teacher_id=<%= teacher.getId() %>">Delete</a></td>
                                        </tr>
                                        <% 
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Subject Management-->
            <h2 class="mt-5">Subject Management</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            Add Subject
                        </div>
                        <div class="card-body">
                            <form action="add_new_subject" method="post">
                                <div class="form-group">
                                    <label for="subjectName">Name</label>
                                    <input type="text" class="form-control" name="name" placeholder="Enter Subject Name">
                                </div>
                                <div class="form-group">
                                    <label for="teacherId">Teacher ID</label>
                                    <input type="number" class="form-control" name="teacher_id" placeholder="Enter Teacher ID">
                                </div>
                                <button type="submit" class="btn btn-primary">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            Subjects
                        </div>
                        <div class="card-body">
                            <div class="table-responsive" style="max-height: 250px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Teacher</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Subject> subjects = dBConnection.getAllSubjects();
                                            for (Subject subject : subjects) {
                                        %>
                                        <tr>
                                            <td><%= subject.getId() %></td>
                                            <td><%= subject.getName() %></td>
                                            <td><%= subject.getTeacherName() %></td>
                                            <td><a class="btn btn-danger btn-sm" href="delete_subject?subject_id=<%= subject.getId() %>">Delete</a></td>
                                        </tr>
                                        <% 
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Student Management-->
            <h2 class="mt-5">Student Management</h2>
            <div class="row mb-5">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            Add New Student
                        </div>
                        <div class="card-body">
                            <form  action="add_new_student" method="post">
                                <div class="form-group">
                                    <label for="studentName">Name</label>
                                    <input type="text" class="form-control" name="name" placeholder="Enter Student Name">
                                </div>
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" name="username" placeholder="Enter Username">
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="text" class="form-control" name="password" placeholder="Enter Password">
                                </div>
                                <button type="submit" class="btn btn-primary">Add</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            Students
                        </div>
                        <div class="card-body">
                            <div class="table-responsive" style="max-height: 250px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Name</th>
                                            <th>Username</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<Student> students = dBConnection.getAllStudents();
                                            for (Student student : students) {
                                        %>
                                        <tr>
                                            <td><%= student.getId() %></td>
                                            <td><%= student.getName() %></td>
                                            <td><%= student.getUsername() %></td>
                                            <td><a class="btn btn-danger btn-sm" href="delete_student?student_id=<%= student.getId() %>">Delete</a></td>
                                        </tr>
                                        <% 
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Student Enrollment-->
            <h2 class="mt-5">Student Enrollment</h2>
            <div class="row mb-5">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            Enrollment Student for Subject
                        </div>
                        <div class="card-body">
                            <form  action="enroll_student_subject" method="post">
                                <div class="form-group">
                                    <label for="studentName">Student ID</label>
                                    <input type="text" class="form-control" name="student_id" placeholder="Enter Student Name">
                                </div>
                                <div class="form-group">
                                    <label for="username">Subject ID</label>
                                    <input type="text" class="form-control" name="subject_id" placeholder="Enter Username">
                                </div>
                                <button type="submit" class="btn btn-primary">Enroll</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            Students - Subjects
                        </div>
                        <div class="card-body">
                            <div class="table-responsive" style="max-height: 250px;">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>Student ID</th>
                                            <th>Student Name</th>
                                            <th>Subject ID</th>
                                            <th>Subject Name</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            List<StudentSubject> studentsubjects = dBConnection.getAllStudentSubjects();
                                            for (StudentSubject studentsubject : studentsubjects) {
                                        %>
                                        <tr>
                                            <td><%= studentsubject.getStudentId() %></td>
                                            <td><%= studentsubject.getStudentName() %></td>
                                            <td><%= studentsubject.getSubjectId() %></td>
                                            <td><%= studentsubject.getSubjectName() %></td>
                                            <td><a class="btn btn-danger btn-sm" href="delete_student_subject?student_subject_id=<%= studentsubject.getId() %>">Delete</a></td>
                                        </tr>
                                        <% 
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>

    </body>
</html>
