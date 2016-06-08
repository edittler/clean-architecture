package com.clean.domain.interactors.enroll_to_course;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.AbstractInteractor;
import com.clean.domain.model.Course;
import com.clean.domain.repository.StudentRepository;

import java.util.List;
import java.util.Map;


/**
 * Created by fabrizio on 26/05/16.
 */
public class EnrollToCourseImpl extends AbstractInteractor implements EnrollToCourse {

    private StudentRepository mRepository;
    private int mSubjectCode;
    private int mCourseId;
    private EnrollToCourse.Callback mCallback;


    public EnrollToCourseImpl(Executor threadExecutor, MainThread mainThread, EnrollToCourse.Callback callback,
                              StudentRepository repository, int subjectCode, int courseId) {
        super(threadExecutor, mainThread);
        mSubjectCode = subjectCode;
        mCourseId = courseId;
        mRepository = repository;
        mCallback = callback;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void notifyError() {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onRetrievalFailed("Nothing to welcome you with :(");
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void notifySubjectAlreadyEnrolled() {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onSubjectAlreadyEnrolled();
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void notifyEnrolledInSevenCourses() {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onMoreThanSevenCoursesEnrolled();
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void notifyEnrolled() {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onCourseEnrolled();
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/


    @Override
    public void run() {
        Integer subjectCode = mSubjectCode;
        Map<Integer, Course> enrolledCourses = mRepository.getEnrolledCourses();
        if (enrolledCourses.containsKey(subjectCode)) {
            notifySubjectAlreadyEnrolled();
            return;
        }
        if (enrolledCourses.size() >= 7) {
            notifyEnrolledInSevenCourses();
            return;
        }
        Course course = mRepository.getCourse(mSubjectCode, mCourseId);
        mRepository.enrollCourse(mSubjectCode, course);
        notifyEnrolled();
    }
}
