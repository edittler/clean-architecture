package com.clean.presentation.model;


/**
 * Class that represents a SubjectModel in the domain layer.
 */
public class SubjectModel {

    private String mName;
    private Integer mCode;
    /*private String mDepartament;
    private int mCredits;
    private List<Course> mCourses;*/

    /*public SubjectModel() {
        mCourses = new ArrayList<>();
    }*/

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


    /*public void addCourse(Course course) {
        mCourses.add(course);
    }

    public void setCourses(List<Course> courses) {
        for (int i = 0; i < courses.size(); i++) {
            addCourse(courses.get(i));
        }
    }*/

    public Integer getCode() {
        return mCode;
    }

    public String getName() {
        return mName;
    }


}
