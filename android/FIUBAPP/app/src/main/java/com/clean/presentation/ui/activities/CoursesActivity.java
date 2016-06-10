package com.clean.presentation.ui.activities;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.widget.Toast;

import com.clean.R;
import com.clean.presentation.UniquePointOfInstanciation;
import com.clean.presentation.mapper.CourseModelMapper;
import com.clean.presentation.model.CourseModel;
import com.clean.presentation.presenters.BasePresenter;
import com.clean.presentation.presenters.courses.CoursesPresenter;
import com.clean.presentation.ui.adapters.CoursesNamesRecyclerAdapter;

import java.util.ArrayList;
import java.util.List;

import butterknife.ButterKnife;

public class CoursesActivity extends AppCompatActivity implements CoursesPresenter.View {

    public static final String SUBJECT_CODE = "code";
    public static final String SUBJECT_NAME = "name";
    private BasePresenter mPresenter;
    private RecyclerView mCoursesView;
    private List<CourseModel> mCourses;
    private int mSubjectCode;

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_courses);
        ButterKnife.bind(this);
        getSupportActionBar().setTitle(getIntent().getStringExtra(SUBJECT_NAME));

        mCourses = new ArrayList<>();
        mCoursesView = (RecyclerView) findViewById(R.id.recyclerview);
        mCoursesView.setLayoutManager(new LinearLayoutManager(mCoursesView.getContext()));
        mCoursesView.setAdapter(new CoursesNamesRecyclerAdapter(this, mCourses));
        this.initialize();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void initialize() {
        // create a presenter for this view
        mSubjectCode = getSubjectCode();
        ((CoursesNamesRecyclerAdapter) mCoursesView.getAdapter()).setSubjectCode(mSubjectCode);
        mPresenter = UniquePointOfInstanciation.initializeCourses(this, mSubjectCode);
        mPresenter.resume();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    public int getSubjectCode() {
        Toast.makeText(this, getIntent().getStringExtra(SUBJECT_NAME),Toast.LENGTH_SHORT).show();
        return getIntent().getIntExtra(SUBJECT_CODE, 0);
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
    public void displayCourses(List courses) {
        mCourses = CourseModelMapper.transform(courses);
        Log.e("dsada", courses.toString());
        Log.e("dsada", courses.toString());
        mCoursesView.setAdapter(new CoursesNamesRecyclerAdapter(this, mCourses));
        ((CoursesNamesRecyclerAdapter) mCoursesView.getAdapter()).setSubjectCode(mSubjectCode);
        mCoursesView.getAdapter().notifyDataSetChanged();
        mCoursesView.invalidate();
    }
}
