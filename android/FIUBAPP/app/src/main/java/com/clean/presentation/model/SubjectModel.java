package com.clean.presentation.model;

/**
 * Class that represents a SubjectModel in the domain layer.
 */
public class SubjectModel {

    private String mName;
    private Integer mCode;

    private SubjectModel() {}

    public static SubjectModel buildSubjectModel(){
        return new SubjectModel();
    }

    public SubjectModel addName(String name) {
        mName = name;
        return this;
    }

    public SubjectModel addCode(int code) {
        mCode = code;
        return this;
    }

    public Integer getCode() {
        return mCode;
    }

    public String getName() {
        return mName;
    }


}
