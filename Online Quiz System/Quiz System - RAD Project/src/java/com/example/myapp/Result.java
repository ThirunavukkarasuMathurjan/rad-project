
package com.example.myapp;

import java.sql.Date;

public class Result {

    private int id;
    private String student_username;
    private String student_name;
    private String subject;
    private String quiz;
    private double score;
    private Date completed_date;

    // Getters
    public int getId() {
        return id;
    }

    public String getStudentUsername() {
        return student_username;
    }

    public String getStudentName() {
        return student_name;
    }

    public String getSubject() {
        return subject;
    }

    public String getQuiz() {
        return quiz;
    }

    public double getScore() {
        return score;
    }

    public Date getCompletedDate() {
        return completed_date;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setStudentUsername(String student_username) {
        this.student_username = student_username;
    }

    public void setStudentName(String student_name) {
        this.student_name = student_name;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public void setQuiz(String quiz) {
        this.quiz = quiz;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public void setCompletedDate(Date completed_date) {
        this.completed_date = completed_date;
    }
}
