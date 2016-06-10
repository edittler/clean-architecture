package com.clean.presentation.ui.activities;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;

import com.clean.R;
import com.clean.presentation.UniquePointOfInstanciation;
import com.clean.presentation.presenters.enroll_to_course.EnrollToCoursePresenter;
import com.clean.presentation.ui.dialogs.NotifyDialog;

/**
 * Created by fabrizio on 07/06/16.
 */
public class EnrollToCourseActivity extends AppCompatActivity implements EnrollToCoursePresenter.View{

    public static String COURSE_ID = "course_id";
    public static String SUBJECT_CODE = "subject_code";
    private EnrollToCoursePresenter mPresenter;

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onCreate(Bundle savedInstance) {
        super.onCreate(savedInstance);
        int subjectCode = getSubjectCode();
        int courseId = getCourseId();
        mPresenter = UniquePointOfInstanciation.initializeEnrollToCourse(this, subjectCode, courseId);
        mPresenter.resume();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public int getSubjectCode() {
        return getIntent().getIntExtra(SUBJECT_CODE, 0);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public int getCourseId() {
        return getIntent().getIntExtra(COURSE_ID, 0);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void showProgress() {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void hideProgress() {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void showError(String message) {

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void notifyAlreadyEnrolledSubject() {
        NotifyDialog.build(this, getString(R.string.error_title), getString(R.string.same_subject)).show();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void notifyEnrolledInSevenCourses() {
        NotifyDialog.build(this, getString(R.string.error_title), getString(R.string.limit)).show();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void notifyEnrolled() {
        NotifyDialog.build(this, getString(R.string.sucess_title), getString(R.string.sucess_enroll)).show();
    }
}
