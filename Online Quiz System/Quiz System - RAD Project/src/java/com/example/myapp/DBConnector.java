
package com.example.myapp;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnector {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/quiz_system";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    public int validateUser(String username, String password, String role) throws SQLException {
        try (Connection connection = DBConnector.getConnection()) {
            String sql = "SELECT id FROM " + role + " WHERE username = ? AND password = ?";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, username);
            statement.setString(2, password);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt("id");
            } else {
                return 0;
            }
        }
    }

    public Student getStudentById(int id) throws SQLException {
        Student student = null;
        String sql = "SELECT * FROM student WHERE id = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    student = new Student();
                    student.setId(resultSet.getInt("id"));
                    student.setUsername(resultSet.getString("username"));
                    student.setPassword(resultSet.getString("password"));
                    student.setName(resultSet.getString("name"));
                }
            }
        }
        return student;
    }

    public List<Teacher> getAllTeachers() throws SQLException {
        List<Teacher> teachers = new ArrayList<>();
        String sql = "SELECT * FROM teacher";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Teacher teacher = new Teacher();
                    teacher.setId(resultSet.getInt("id"));
                    teacher.setName(resultSet.getString("name"));
                    teacher.setUsername(resultSet.getString("username"));
                    teacher.setPassword(resultSet.getString("password"));

                    teachers.add(teacher);
                }
            }
        }

        return teachers;
    }

    public List<Student> getAllStudents() throws SQLException {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM student";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Student student = new Student();
                    student.setId(resultSet.getInt("id"));
                    student.setName(resultSet.getString("name"));
                    student.setUsername(resultSet.getString("username"));
                    student.setPassword(resultSet.getString("password"));

                    students.add(student);
                }
            }
        }

        return students;
    }

    public Teacher getTeacherById(int id) throws SQLException {
        Teacher teacher = null;
        String sql = "SELECT * FROM teacher WHERE id = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    teacher = new Teacher();
                    teacher.setId(resultSet.getInt("id"));
                    teacher.setUsername(resultSet.getString("username"));
                    teacher.setPassword(resultSet.getString("password"));
                    teacher.setName(resultSet.getString("name"));
                }
            }
        }
        return teacher;
    }

    public List<Quiz> getStudentPendingQuizzes(int id) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quiz q "
                + "JOIN subject s ON q.subject_id = s.id "
                + "JOIN student_subject ss ON s.id = ss.subject_id "
                + "WHERE q.id NOT IN (SELECT r.quiz_id FROM results r WHERE r.student_id = ?) "
                + "AND ss.student_id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            statement.setInt(2, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(resultSet.getInt("id"));
                    quiz.setName(resultSet.getString("name"));
                    quiz.setDescription(resultSet.getString("description"));
                    quiz.setSubject(resultSet.getString("s.name"));
                    quiz.setDeadline(resultSet.getDate("deadline"));
                    quiz.setDuration(resultSet.getInt("duration"));

                    quizzes.add(quiz);
                }
            }
        }

        return quizzes;
    }

    public List<Results> getStudentCompletedQuizzes(int id) throws SQLException {
        List<Results> results = new ArrayList<>();
        String sql = "SELECT s.name AS Subject, q.name AS Quiz_Name, r.completed_date AS Completed_Date, r.score AS Score "
                + "FROM student_subject ss "
                + "JOIN subject s ON ss.subject_id = s.id "
                + "JOIN quiz q ON s.id = q.subject_id "
                + "JOIN results r ON q.id = r.quiz_id "
                + "WHERE ss.student_id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Results result = new Results();
                    result.setSubject(resultSet.getString("Subject"));
                    result.setQuiz(resultSet.getString("Quiz_Name"));
                    result.setScore(resultSet.getDouble("Score"));
                    result.setCompleted_date(resultSet.getDate("Completed_Date"));

                    results.add(result);
                }
            }
        }

        return results;
    }

    public Quiz getQuizById(int id) throws SQLException {
        Quiz quiz = null;
        String sql = "SELECT * FROM quiz JOIN subject ON quiz.subject_id = subject.id WHERE quiz.id = ?";
        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    quiz = new Quiz();
                    quiz.setId(resultSet.getInt("id"));
                    quiz.setName(resultSet.getString("name"));
                    quiz.setSubject(resultSet.getString("subject.name"));
                    quiz.setDescription(resultSet.getString("description"));
                    quiz.setDeadline(resultSet.getDate("deadline"));
                    quiz.setDuration(resultSet.getInt("duration"));
                }
            }
        }
        return quiz;
    }

    public List<Quiz> getTeacherOngoingQuizzes(int id) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quiz JOIN subject ON subject_id = subject.id WHERE subject.teacher_id = ? AND deadline >= CURDATE();";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(resultSet.getInt("id"));
                    quiz.setName(resultSet.getString("name"));
                    quiz.setSubject(resultSet.getString("subject.name"));
                    quiz.setDeadline(resultSet.getDate("deadline"));
                    quiz.setDuration(resultSet.getInt("duration"));

                    quizzes.add(quiz);
                }
            }
        }

        return quizzes;
    }

    public List<Quiz> getTeacherCompltedQuizzes(int id) throws SQLException {
        List<Quiz> quizzes = new ArrayList<>();
        String sql = "SELECT * FROM quiz JOIN subject ON subject_id = subject.id WHERE subject.teacher_id = ? AND deadline < CURDATE();";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Quiz quiz = new Quiz();
                    quiz.setId(resultSet.getInt("id"));
                    quiz.setName(resultSet.getString("name"));
                    quiz.setSubject(resultSet.getString("subject.name"));
                    quiz.setDeadline(resultSet.getDate("deadline"));
                    quiz.setDuration(resultSet.getInt("duration"));

                    quizzes.add(quiz);
                }
            }
        }

        return quizzes;
    }

    public List<Result> getQuizResults(int id) throws SQLException {
        List<Result> results = new ArrayList<>();
        String sql = "SELECT * FROM results JOIN student ON results.student_id = student.id JOIN quiz ON results.quiz_id = quiz.id WHERE quiz.id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Result result = new Result();
                    result.setId(resultSet.getInt("id"));
                    result.setStudentUsername(resultSet.getString("student.username"));
                    result.setStudentName(resultSet.getString("student.name"));
                    result.setCompletedDate(resultSet.getDate("results.completed_date"));
                    result.setScore(resultSet.getDouble("results.score"));

                    results.add(result);
                }
            }
        }

        return results;
    }

    public List<Question> getQuizQuestions(int quiz_id) throws SQLException {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM answer JOIN question ON answer.question_id = question.id WHERE question.quiz_id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, quiz_id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Question question = new Question();
                    question.setId(resultSet.getInt("question.id"));
                    question.setQuestion(resultSet.getString("question.question"));
                    question.setAnswer1(resultSet.getString("answer.choice1"));
                    question.setAnswer2(resultSet.getString("answer.choice2"));
                    question.setAnswer3(resultSet.getString("answer.choice3"));
                    question.setAnswer4(resultSet.getString("answer.choice4"));
                    question.setCorrectAnswer(resultSet.getInt("answer.correct"));

                    questions.add(question);
                }
            }
        }

        return questions;
    }

    public Question getQuestion(int question_id) throws SQLException {
        Question question = new Question();
        String sql = "SELECT * FROM answer JOIN question ON answer.question_id = question.id WHERE answer.question_id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, question_id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    question.setId(resultSet.getInt("question_id"));
                    question.setAnswer1(resultSet.getString("choice1"));
                    question.setAnswer2(resultSet.getString("choice2"));
                    question.setAnswer3(resultSet.getString("choice3"));
                    question.setAnswer4(resultSet.getString("choice4"));
                    question.setCorrectAnswer(resultSet.getInt("correct"));
                }
            }
        }

        return question;
    }

    public static void submitScore(int student_id, int quiz_id, int score) throws SQLException {
        String sql = "INSERT INTO results (student_id, quiz_id, score, completed_date) VALUES (?, ?, ?, '2023-09-09')";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, student_id);
            statement.setInt(2, quiz_id);
            statement.setInt(3, score);
            statement.executeUpdate();
        }
    }

    public List<Subject> getAllSubjects() throws SQLException {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT * FROM subject JOIN teacher ON subject.teacher_id = teacher.id";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Subject subject = new Subject();
                    subject.setId(resultSet.getInt("subject.id"));
                    subject.setName(resultSet.getString("subject.name"));
                    subject.setTeacherId(resultSet.getInt("subject.teacher_id"));
                    subject.setTeacherName(resultSet.getString("teacher.name"));
                    subjects.add(subject);
                }
            }
        }

        return subjects;
    }

    public List<Subject> getSubjectsByTeacherId(int teacher_id) throws SQLException {
        List<Subject> subjects = new ArrayList<>();
        String sql = "SELECT * FROM subject WHERE teacher_id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, teacher_id);

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Subject subject = new Subject();
                    subject.setId(resultSet.getInt("id"));
                    subject.setName(resultSet.getString("name"));
                    subjects.add(subject);
                }
            }
        }

        return subjects;
    }

    public static int addNewQuiz(String quiz_name, String description, int subject_id, String deadline, int duration) throws SQLException {
        String sql = "INSERT INTO quiz (name, description, subject_id, deadline, duration) VALUES (?, ?, ?, ?, ?)";
        int generatedId = -1;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, quiz_name);
            statement.setString(2, description);
            statement.setInt(3, subject_id);
            statement.setString(4, deadline);
            statement.setInt(5, duration);
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        }
        return generatedId;
    }

    public static int addNewQuestion(String question, int quiz_id) throws SQLException {
        String sql = "INSERT INTO question (question, quiz_id) VALUES (?, ?)";
        int generatedId = -1;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, question);
            statement.setInt(2, quiz_id);
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        }

        return generatedId;
    }

    public static void addNewAnswer(int question_id, String choice1, String choice2, String choice3, String choice4, int correct) throws SQLException {
        String sql = "INSERT INTO answer (question_id, choice1, choice2, choice3, choice4, correct) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, question_id);
            statement.setString(2, choice1);
            statement.setString(3, choice2);
            statement.setString(4, choice3);
            statement.setString(5, choice4);
            statement.setInt(6, correct);
            statement.executeUpdate();
        }
    }

    public static int addNewTeacher(String name, String username, String password) throws SQLException {
        String sql = "INSERT INTO teacher (name, username, password) VALUES (?, ?, ?)";
        int generatedId = -1;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, name);
            statement.setString(2, username);
            statement.setString(3, password);
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        }
        return generatedId;
    }
    
    public static int addNewStudent(String name, String username, String password) throws SQLException {
        String sql = "INSERT INTO student (name, username, password) VALUES (?, ?, ?)";
        int generatedId = -1;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, name);
            statement.setString(2, username);
            statement.setString(3, password);
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        }
        return generatedId;
    }
    
    public static int addNewSubject(String name, int teacherID) throws SQLException {
        String sql = "INSERT INTO subject (name, teacher_id) VALUES (?, ?)";
        int generatedId = -1;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, name);
            statement.setInt(2, teacherID);
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        }
        return generatedId;
    }
    
    public static boolean deleteTeacher(int teacher_id) throws SQLException {
        String sql = "DELETE FROM teacher WHERE id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, teacher_id);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static boolean deleteSubject(int subject_id) throws SQLException {
        String sql = "DELETE FROM subject WHERE id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, subject_id);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public static boolean deleteStudent(int student_id) throws SQLException {
        String sql = "DELETE FROM student WHERE id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, student_id);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    public List<StudentSubject> getAllStudentSubjects() throws SQLException {
        List<StudentSubject> studentSubjects = new ArrayList<>();
        String sql = "SELECT * FROM student_subject JOIN student ON student_subject.student_id = student.id JOIN subject ON student_subject.subject_id = subject.id";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {

            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    StudentSubject studentSubject = new StudentSubject();
                    studentSubject.setId(resultSet.getInt("student_subject.id"));
                    studentSubject.setStudentId(resultSet.getInt("student.id"));
                    studentSubject.setStudentName(resultSet.getString("student.name"));
                    studentSubject.setSubjectId(resultSet.getInt("subject.id"));
                    studentSubject.setSubjectName(resultSet.getString("subject.name"));

                    studentSubjects.add(studentSubject);
                }
            }
        }

        return studentSubjects;
    }

    public static int enrollStudentSubject(int student_id, int subject_id) throws SQLException {
        String sql = "INSERT INTO student_subject (student_id, subject_id) VALUES (?, ?)";
        int generatedId = -1;

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, student_id);
            statement.setInt(2, subject_id);
            statement.executeUpdate();

            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    generatedId = generatedKeys.getInt(1);
                }
            }
        }
        return generatedId;
    }
    
    public static boolean deleteStudentSubject(int student_subject_id) throws SQLException {
        String sql = "DELETE FROM student_subject WHERE id = ?";

        try (Connection connection = getConnection(); PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, student_subject_id);
            statement.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
    
    
}
