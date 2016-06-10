package com.clean.presentation.presenters.enrolled_courses;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.show_enrolled_courses.ShowEnrolledCourses;
import com.clean.domain.interactors.show_enrolled_courses.ShowEnrolledCoursesImpl;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.AbstractPresenter;

import java.util.List;

/**
 * Created by dmilicic on 12/13/15.
 */
public class EnrolledCoursesPresenterImpl extends AbstractPresenter implements EnrolledCoursesPresenter,
        ShowEnrolledCourses.Callback {

    private View mView;
    private StudentRepository mRepository;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public EnrolledCoursesPresenterImpl(Executor executor,
                                        MainThread mainThread,
                                        View view,
                                        StudentRepository repository) {
        super(executor, mainThread);
        mView = view;
        mRepository = repository;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void resume() {
        mView.showProgress();

        // initialize the interactor
        ShowEnrolledCourses interactor = new ShowEnrolledCoursesImpl(
                mExecutor,
                mMainThread,
                this,
                mRepository
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
    public void onCoursesRetrieved(List courses) {
        mView.displayCourses(courses);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onRetrievalFailed(String error) {

    }
}
