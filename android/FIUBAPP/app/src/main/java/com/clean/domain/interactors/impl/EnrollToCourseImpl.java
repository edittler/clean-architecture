package com.clean.domain.interactors.impl;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.base.AbstractInteractor;
import com.clean.domain.interactors.base.EnrollToCourse;

/**
 * Created by fabrizio on 26/05/16.
 */
public class EnrollToCourseImpl extends AbstractInteractor implements EnrollToCourse {

    public EnrollToCourseImpl(Executor threadExecutor, MainThread mainThread) {
        super(threadExecutor, mainThread);
    }

    @Override
    public void run() {

    }
}
