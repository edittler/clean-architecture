package com.clean.domain.interactors.impl;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.base.AbstractInteractor;
import com.clean.domain.interactors.base.ShowCourses;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ShowCoursesImpl extends AbstractInteractor implements ShowCourses {

    public ShowCoursesImpl(Executor threadExecutor, MainThread mainThread) {
        super(threadExecutor, mainThread);
    }

    @Override
    public void run() {

    }
}
