package com.clean.domain.model;

import java.util.List;

/**
 * Class that represents a Course in the domain layer.
 */
public class Course {

    private Integer mId;
    private String mProffesor;
    private String mHeadsOfTPs;
    private List<String> TeachingAssistants;
    private String mTime;
    private String mClassroom;
    private int mSemester;

    public Course() {}

    public Integer getId() {
        return mId;
    }

}
