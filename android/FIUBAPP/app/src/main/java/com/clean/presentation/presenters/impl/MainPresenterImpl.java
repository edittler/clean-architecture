package com.clean.presentation.presenters.impl;

import com.clean.data.RestApi;
import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.base.ShowDegreePrograms;
import com.clean.domain.interactors.impl.ShowDegreeProgramsImpl;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.base.AbstractPresenter;
import com.clean.presentation.presenters.MainPresenter;

import org.json.JSONArray;

/**
 * Created by dmilicic on 12/13/15.
 */
public class MainPresenterImpl extends AbstractPresenter implements MainPresenter,
        ShowDegreePrograms.Callback {

    private MainPresenter.View mView;
    private StudentRepository mRepository;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public MainPresenterImpl(Executor executor,
                             MainThread mainThread,
                             View view) {
        super(executor, mainThread);
        mView = view;
        mRepository = new RestApi();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void resume() {
        mView.showProgress();

        // initialize the interactor
        ShowDegreePrograms interactor = new ShowDegreeProgramsImpl(
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
    public void onDegreeProgramsRetrieved(JSONArray programs) {
        mView.displayDegreePrograms(programs);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void onRetrievalFailed(String error) {

    }
}
