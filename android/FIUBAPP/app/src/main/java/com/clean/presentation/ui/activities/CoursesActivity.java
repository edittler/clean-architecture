package com.clean.presentation.ui.activities;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.Toast;

import com.clean.R;
import com.clean.presentation.UniquePointOfInstanciation;
import com.clean.presentation.presenters.BasePresenter;
import com.clean.presentation.presenters.courses.CoursesPresenter;
import com.clean.presentation.presenters.main.MainPresenter;
import com.clean.presentation.ui.adapters.SimpleStringRecyclerViewAdapter;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.List;

import butterknife.ButterKnife;

public class CoursesActivity extends AppCompatActivity implements CoursesPresenter.View {

    public static final String SUBJECT_CODE = "code";
    public static final String SUBJECT_NAME = "name";
    private BasePresenter mPresenter;
    private RecyclerView mCoursesView;
    private List<String> mCourses;

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_courses);
        ButterKnife.bind(this);
        getSupportActionBar().setTitle(R.string.courses);

        mCourses = new ArrayList<>();
        mCoursesView = (RecyclerView) findViewById(R.id.recyclerview);
        mCoursesView.setLayoutManager(new LinearLayoutManager(mCoursesView.getContext()));
        mCoursesView.setAdapter(new SimpleStringRecyclerViewAdapter(this, mCourses));
        this.initialize();
        Toast.makeText(this, getIntent().getStringExtra(SUBJECT_NAME),Toast.LENGTH_SHORT).show();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void initialize() {
        // create a presenter for this view
        mPresenter = UniquePointOfInstanciation.initializeCourses(this);
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
    public void displayCourses(JSONArray courses) {

    }
}
