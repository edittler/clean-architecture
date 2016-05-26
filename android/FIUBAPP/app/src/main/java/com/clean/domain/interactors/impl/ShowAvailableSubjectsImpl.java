package com.clean.domain.interactors.impl;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.base.AbstractInteractor;
import com.clean.domain.interactors.base.ShowAvailableSubjects;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ShowAvailableSubjectsImpl extends AbstractInteractor implements ShowAvailableSubjects {

    public ShowAvailableSubjectsImpl(Executor threadExecutor, MainThread mainThread) {
        super(threadExecutor, mainThread);
    }

    @Override
    public void run() {

    }

}
