package com.clean.domain.interactors.show_courses;

import com.clean.domain.interactors.Interactor;

import org.json.JSONArray;

/**
 * Created by fabrizio on 26/05/16.
 */
public interface ShowCourses extends Interactor {

    interface Callback {

        void onCoursesRetrieved(JSONArray courses);

        void onRetrievalFailed(String error);
    }
}
