package com.clean.presentation.model;

import java.util.List;

/**
 * Created by fabrizio on 06/06/16.
 */
public class CourseModel {

    private Integer mId;
    private List<String> mTeachers;
    private String mSchedule;
    private String mClassroom;
    private int mVacancy;

    private CourseModel() {
    }

    public static CourseModel buildCourseModel(){
        return new CourseModel();
    }


    public CourseModel addId(int id) {
        mId = id;
        return this;
    }

    public CourseModel addTeachers(List<String> teachers) {
        mTeachers = teachers;
        return this;
    }

    public CourseModel addSchedule(String schedule) {
        mSchedule = schedule;
        return this;
    }

    public CourseModel addClassroom(String classroom) {
        mClassroom = classroom;
        return this;
    }

    public CourseModel addVacancy(int vacancy) {
        mVacancy = vacancy;
        return this;
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
