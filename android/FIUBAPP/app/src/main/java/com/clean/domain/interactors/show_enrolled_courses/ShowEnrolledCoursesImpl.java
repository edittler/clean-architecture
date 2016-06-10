package com.clean.domain.interactors.show_enrolled_courses;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.AbstractInteractor;
import com.clean.domain.model.Course;
import com.clean.domain.model.Subject;
import com.clean.domain.repository.StudentRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ShowEnrolledCoursesImpl extends AbstractInteractor implements ShowEnrolledCourses {

    private StudentRepository mRepository;
    private Callback mCallback;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public ShowEnrolledCoursesImpl(Executor threadExecutor, MainThread mainThread,
                                   Callback callback, StudentRepository repo) {
        super(threadExecutor, mainThread);
        mRepository = repo;
        mCallback = callback;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void notifyError() {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onRetrievalFailed("Nothing to welcome you with :(");
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void postCourses(final List courses) {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onCoursesRetrieved(courses);
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void run() {
        // retrieve the message
        final Map<Integer, Course> courses = mRepository.getEnrolledCourses();

        // check if we have failed to retrieve our message
        if (courses == null || courses.size() == 0) {
            // notify the failure on the main thread
            notifyError();
            return;
        }

        Set<Integer> keys = courses.keySet();
        List<String> enrolledCourses = new ArrayList<>();

        for (Integer key : keys) {
            String courseString = "Curso " + Integer.toString(courses.get(key).getId());
            Subject subject = mRepository.getSubject(key.intValue());
            String enrolledCourse = subject.getName() + ", " + courseString;
            enrolledCourses.add(enrolledCourse);
        }

        // we have retrieved our message, notify the UI on the main thread
        postCourses(enrolledCourses);
    }

}
