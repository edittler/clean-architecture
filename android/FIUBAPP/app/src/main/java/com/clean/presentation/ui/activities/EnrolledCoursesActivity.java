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
import com.clean.presentation.presenters.enrolled_courses.EnrolledCoursesPresenter;
import com.clean.presentation.ui.adapters.CoursesNamesRecyclerAdapter;
import com.clean.presentation.ui.adapters.SimpleStringRecyclerViewAdapter;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import butterknife.ButterKnife;

public class EnrolledCoursesActivity extends AppCompatActivity implements EnrolledCoursesPresenter.View {

    private BasePresenter mPresenter;
    private RecyclerView mInscriptionsView;
    private List<String> mInscriptions;

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_enrolled_courses);
        ButterKnife.bind(this);
        getSupportActionBar().setTitle(getString(R.string.inscriptions));

        mInscriptions = new ArrayList<>();
        mInscriptionsView = (RecyclerView) findViewById(R.id.recyclerview);
        mInscriptionsView.setLayoutManager(new LinearLayoutManager(mInscriptionsView.getContext()));
        mInscriptionsView.setAdapter(new SimpleStringRecyclerViewAdapter(this, mInscriptions));
        this.initialize();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void initialize() {
        // create a presenter for this view
        mPresenter = UniquePointOfInstanciation.initializeEnrolledCourses(this);
        mPresenter.resume();
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
        //mInscriptions = CourseModelMapper.transform(courses);
        Log.e("dsada", courses.toString());
        Log.e("dsada", courses.toString());
        mInscriptions = courses;
        mInscriptionsView.setAdapter(new SimpleStringRecyclerViewAdapter(this, mInscriptions));
        mInscriptionsView.getAdapter().notifyDataSetChanged();
        mInscriptionsView.invalidate();
    }

}
