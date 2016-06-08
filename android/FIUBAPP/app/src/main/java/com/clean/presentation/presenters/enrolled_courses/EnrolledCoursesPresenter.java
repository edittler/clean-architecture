package com.clean.presentation.presenters.enrolled_courses;

import com.clean.presentation.presenters.BasePresenter;
import com.clean.presentation.ui.BaseView;

import java.util.List;
import java.util.Map;


public interface EnrolledCoursesPresenter extends BasePresenter {

    interface View extends BaseView {
        void displayCourses(List courses);
        // TODO: Add your view methods
    }

    // TODO: Add your presenter methods

}
