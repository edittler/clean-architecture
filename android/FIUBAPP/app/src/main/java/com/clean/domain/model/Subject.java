package com.clean.domain.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Class that represents a Subject in the domain layer.
 */
public class Subject {

    private String mName;
    private Integer mCode;
    private String mDepartament;
    private int mCredits;
    private List<Course> mCourses;

    public Subject() {
        mCourses = new ArrayList<>();
    }

    public void setName(String name) {
        mName = name;
    }

    public void setCode(int code) {
        mCode = code;
    }

    public void setDepartament(String departament) {
        mDepartament = departament;
    }

    public void setCredits(int credits) {
        mCredits = credits;
    }

    public void addCourse(Course course) {
        mCourses.add(course);
    }

    public void setCourses(List<Course> courses) {
        for (int i = 0; i < courses.size(); i++) {
            addCourse(courses.get(i));
        }
    }

    public Integer getCode() {
        return mCode;
    }
}
