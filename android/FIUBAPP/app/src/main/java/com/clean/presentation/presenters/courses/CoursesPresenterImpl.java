package com.clean.presentation.presenters.courses;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.show_courses.ShowCourses;
import com.clean.domain.interactors.show_courses.ShowCoursesImpl;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.AbstractPresenter;

import java.util.List;

/**
 * Created by dmilicic on 12/13/15.
 */
public class CoursesPresenterImpl extends AbstractPresenter implements CoursesPresenter,
        ShowCourses.Callback {

    private View mView;
    private StudentRepository mRepository;
    private int mSubjectCode;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public CoursesPresenterImpl(Executor executor,
                                MainThread mainThread,
                                View view,
                                StudentRepository repository,
                                int subjectCode) {
        super(executor, mainThread);
        mView = view;
        mRepository = repository;
        mSubjectCode = subjectCode;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void resume() {
        mView.showProgress();

        // initialize the interactor
        ShowCourses interactor = new ShowCoursesImpl(
                mExecutor,
                mMainThread,
                this,
                mRepository
        );

        interactor.setSubjectCode(mSubjectCode);
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
