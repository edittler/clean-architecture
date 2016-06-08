package com.clean.domain.interactors.show_enrolled_courses;

import com.clean.domain.interactors.Interactor;

import java.util.List;
import java.util.Map;

/**
 * Created by fabrizio on 26/05/16.
 */
public interface ShowEnrolledCourses extends Interactor {

    interface Callback {

        void onCoursesRetrieved(List courses);

        void onRetrievalFailed(String error);
    }

}
