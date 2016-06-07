package com.clean.domain.interactors.show_courses;

import com.clean.domain.interactors.Interactor;

import org.json.JSONArray;

import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */
public interface ShowCourses extends Interactor {

    interface Callback {

        void onCoursesRetrieved(List courses);

        void onRetrievalFailed(String error);
    }

    public void setSubjectCode(int subjectCode);
}
