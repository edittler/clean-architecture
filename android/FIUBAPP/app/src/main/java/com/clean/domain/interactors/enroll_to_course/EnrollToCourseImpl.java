package com.clean.domain.interactors.enroll_to_course;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.AbstractInteractor;

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
