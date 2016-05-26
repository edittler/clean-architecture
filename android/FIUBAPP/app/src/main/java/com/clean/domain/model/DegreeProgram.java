package com.clean.domain.model;

import java.util.List;

/**
 * Class that represents a DegreeProgram in the domain layer.
 */
public class DegreeProgram {

    private String mCollegeDegree;
    private List<Subject> mAvailableSubjects;
    private int mTotalCredits;

    public DegreeProgram(String collegeDegree) {
        mCollegeDegree = collegeDegree;

    }

    public List getAvailableSubjects() {
        return mAvailableSubjects;
    }

    public String getCollegeDegree() {
        return mCollegeDegree;
    }
}
