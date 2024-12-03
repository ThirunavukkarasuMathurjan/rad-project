
package com.example.myapp;

public class Subject {
    private int id;
    private String name;
    private int teacherID;
    private String teacherName;

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }
    
    public int getTeacherId() {
        return teacherID;
    }
    
    public String getTeacherName() {
        return teacherName;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public void setTeacherId(int teacherID) {
        this.teacherID = teacherID;
    }
    
    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }
}
