package com.clean.domain.model;

import java.util.Map;

/**
 * Class that represents a Student in the domain layer.
 */
public class Student {

    private int mStudentId;
    private String mName;
    private DegreeProgram mDegreeProgram;
    private Map<Integer, Course> mEnrolledCourses;

    public Student () {}

    public void enrollToCourse(Subject subject, Course course) {
        mEnrolledCourses.put(subject.getCode(), course);
    }


}
