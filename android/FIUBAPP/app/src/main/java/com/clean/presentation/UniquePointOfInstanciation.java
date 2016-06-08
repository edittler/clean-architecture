package com.clean.presentation;

import android.content.Context;

import com.clean.data.repository.LocalDataBase;
import com.clean.domain.executor.impl.ThreadExecutor;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.courses.CoursesPresenter;
import com.clean.presentation.presenters.courses.CoursesPresenterImpl;
import com.clean.presentation.presenters.enroll_to_course.EnrollToCoursePresenter;
import com.clean.presentation.presenters.enroll_to_course.EnrollToCoursePresenterImpl;
import com.clean.presentation.presenters.enrolled_courses.EnrolledCoursesPresenter;
import com.clean.presentation.presenters.enrolled_courses.EnrolledCoursesPresenterImpl;
import com.clean.presentation.presenters.main.MainPresenter;
import com.clean.presentation.presenters.main.MainPresenterImpl;
import com.clean.threading.MainThreadImpl;

/**
 * Created by fabrizio on 29/05/16.
 */
public class UniquePointOfInstanciation {

    public static Context CONTEXT;
    public static StudentRepository REPOSITORY;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public static void setContext(Context context) {
        CONTEXT = context;
        REPOSITORY = new LocalDataBase(CONTEXT);

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public static MainPresenter initializeGetAvailableSubjects(MainPresenter.View context) {
        return new MainPresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                context,
                REPOSITORY
        );
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public static CoursesPresenter initializeCourses(CoursesPresenter.View context, int subjectCode) {
        return new CoursesPresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                context,
                REPOSITORY,
                subjectCode
        );
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public static EnrollToCoursePresenter initializeEnrollToCourse(EnrollToCoursePresenter.View context,
                                                            int subjectCode, int courseId) {
        return new EnrollToCoursePresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                context,
                REPOSITORY,
                subjectCode,
                courseId
        );
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public static EnrolledCoursesPresenter initializeEnrolledCourses(EnrolledCoursesPresenter.View context) {

        return new EnrolledCoursesPresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                context,
                REPOSITORY
        );
    }

}
