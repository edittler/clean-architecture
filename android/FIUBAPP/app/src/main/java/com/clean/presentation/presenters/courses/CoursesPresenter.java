package com.clean.presentation.presenters.courses;

import com.clean.presentation.presenters.BasePresenter;
import com.clean.presentation.ui.BaseView;

import org.json.JSONArray;


public interface CoursesPresenter extends BasePresenter {

    interface View extends BaseView {
        void displayCourses(JSONArray courses);
        // TODO: Add your view methods
    }

    // TODO: Add your presenter methods

}
