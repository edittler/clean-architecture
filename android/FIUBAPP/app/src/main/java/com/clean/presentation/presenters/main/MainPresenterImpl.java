package com.clean.presentation.presenters.main;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.show_available_subjects.ShowAvailableSubjects;
import com.clean.domain.interactors.show_available_subjects.ShowAvailableSubjectsImpl;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.AbstractPresenter;

import java.util.List;

/**
 * Created by dmilicic on 12/13/15.
 */
public class MainPresenterImpl extends AbstractPresenter implements MainPresenter,
        ShowAvailableSubjects.Callback {

    private MainPresenter.View mView;
    private StudentRepository mRepository;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public MainPresenterImpl(Executor executor,
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
        ShowAvailableSubjects interactor = new ShowAvailableSubjectsImpl(
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
    public void onSubjectsRetrieved(List subjects) {
        mView.displaySubjects(subjects);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onRetrievalFailed(String error) {

    }
}
