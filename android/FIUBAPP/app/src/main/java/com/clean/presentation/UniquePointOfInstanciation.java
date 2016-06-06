package com.clean.presentation;

import com.clean.data.repository.RestApi;
import com.clean.domain.executor.impl.ThreadExecutor;
import com.clean.presentation.presenters.courses.CoursesPresenter;
import com.clean.presentation.presenters.courses.CoursesPresenterImpl;
import com.clean.presentation.presenters.main.MainPresenter;
import com.clean.presentation.presenters.main.MainPresenterImpl;
import com.clean.threading.MainThreadImpl;

/**
 * Created by fabrizio on 29/05/16.
 */
public class UniquePointOfInstanciation {


    public static MainPresenter initializeGetAvailableSubjects(MainPresenter.View context) {
        return new MainPresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                context,
                new RestApi()
        );
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public static CoursesPresenter initializeCourses(CoursesPresenter.View context) {
        return new CoursesPresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                context,
                new RestApi()
        );
    }

}
