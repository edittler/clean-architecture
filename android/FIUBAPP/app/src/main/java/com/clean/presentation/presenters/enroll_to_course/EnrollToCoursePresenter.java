package com.clean.presentation.presenters.enroll_to_course;

import com.clean.presentation.presenters.BasePresenter;
import com.clean.presentation.ui.BaseView;


public interface EnrollToCoursePresenter extends BasePresenter {

    interface View extends BaseView {
        void notifyAlreadyEnrolledSubject();
        void notifyEnrolledInSevenCourses();
        void notifyEnrolled();
        // TODO: Add your view methods
    }

    // TODO: Add your presenter methods

}
