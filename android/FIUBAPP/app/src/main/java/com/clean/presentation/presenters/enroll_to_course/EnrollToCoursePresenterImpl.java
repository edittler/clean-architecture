package com.clean.presentation.presenters.enroll_to_course;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.enroll_to_course.EnrollToCourse;
import com.clean.domain.interactors.enroll_to_course.EnrollToCourseImpl;
import com.clean.domain.interactors.show_courses.ShowCourses;
import com.clean.domain.interactors.show_courses.ShowCoursesImpl;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.AbstractPresenter;

import java.util.List;

/**
 * Created by dmilicic on 12/13/15.
 */
public class EnrollToCoursePresenterImpl extends AbstractPresenter implements EnrollToCoursePresenter,
        EnrollToCourse.Callback {

    private View mView;
    private StudentRepository mRepository;
    private int mSubjectCode;
    private int mCourseId;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public EnrollToCoursePresenterImpl(Executor executor,
                                       MainThread mainThread,
                                       View view,
                                       StudentRepository repository,
                                       int subjectCode,
                                       int courseId) {
        super(executor, mainThread);
        mView = view;
        mRepository = repository;
        mSubjectCode = subjectCode;
        mCourseId = courseId;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void resume() {
        mView.showProgress();

        // initialize the interactor
        EnrollToCourse interactor = new EnrollToCourseImpl(
                mExecutor,
                mMainThread,
                this,
                mRepository,
                mSubjectCode,
                mCourseId
        );

        // run the interactor
        interactor.execute();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void pause() {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void stop() {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void destroy() {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onError(String message) {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onSubjectAlreadyEnrolled() {
        mView.notifyAlreadyEnrolledSubject();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onMoreThanSevenCoursesEnrolled() {
        mView.notifyEnrolledInSevenCourses();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onCourseEnrolled() {
        mView.notifyEnrolled();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onRetrievalFailed(String error) {

    }
}
