package com.clean.domain.interactors.show_courses;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.AbstractInteractor;
import com.clean.domain.model.Course;
import com.clean.domain.repository.StudentRepository;
import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ShowCoursesImpl extends AbstractInteractor implements ShowCourses {

    private StudentRepository mRepository;
    private ShowCourses.Callback mCallback;
    private Integer mSubjectCode;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public ShowCoursesImpl(Executor threadExecutor, MainThread mainThread,
                                     ShowCourses.Callback callback, StudentRepository repo) {
        super(threadExecutor, mainThread);
        mRepository = repo;
        mCallback = callback;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public void setSubjectCode(int subjectCode) {
        mSubjectCode = subjectCode;
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
        if (mSubjectCode == null) {
            return;
        }
        final List<Course> courses = mRepository.getCourses(mSubjectCode);

        // check if we have failed to retrieve our message
        if (courses == null || courses.size() == 0) {
            // notify the failure on the main thread
            notifyError();
            return;
        }

        // we have retrieved our message, notify the UI on the main thread
        postCourses(courses);
    }

}
