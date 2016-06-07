package com.clean.domain.model;

import java.util.List;

/**
 * Class that represents a Course in the domain layer.
 */
public class Course {

    private Integer mId;
    private List<String> mTeachers;
    private String mSchedule;
    private String mClassroom;
    private int mVacancy;

    public Course() {}

    public void setId(int id) {
        mId = id;
    }

    public void setTeachers(List<String> teachers) {
        mTeachers = teachers;
    }

    public void setSchedule(String schedule) {
        mSchedule = schedule;
    }

    public void setClassroom(String classroom) {
        mClassroom = classroom;
    }

    public void setVacancy(int vacancy) {
        mVacancy = vacancy;
    }

    public Integer getId() {
        return mId;
    }

    public List<String> getTeachers() {
        return mTeachers;
    }

    public String getSchedule() {
        return mSchedule;
    }

    public String getClassroom() {
        return mClassroom;
    }

    public int getVacancy() {
        return mVacancy;
    }


}
