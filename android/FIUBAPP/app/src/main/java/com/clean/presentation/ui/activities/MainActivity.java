package com.clean.presentation.ui.activities;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

import com.clean.R;
import com.clean.presentation.UniquePointOfInstanciation;
import com.clean.presentation.model.SubjectModel;
import com.clean.presentation.presenters.main.MainPresenter;
import com.clean.presentation.presenters.main.MainPresenter.View;
import com.clean.presentation.mapper.SubjectModelMapper;
import com.clean.presentation.ui.adapters.SubjectModelRecyclerViewAdapter;

import java.util.ArrayList;
import java.util.List;

import butterknife.ButterKnife;

public class MainActivity extends AppCompatActivity implements View {

    private MainPresenter mPresenter;
    private RecyclerView mSubjectsView;
    private List<SubjectModel> mSubjects;

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);

        mSubjects = new ArrayList<>();
        mSubjectsView = (RecyclerView) findViewById(R.id.recyclerview);
        mSubjectsView.setLayoutManager(new LinearLayoutManager(mSubjectsView.getContext()));
        mSubjectsView.setAdapter(new SubjectModelRecyclerViewAdapter(this, mSubjects));
        this.initialize();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void initialize() {
        // create a presenter for this view
        mPresenter = UniquePointOfInstanciation.initializeGetAvailableSubjects(this);
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
    public void displaySubjects(List subjects) {
        mSubjects = SubjectModelMapper.transform(subjects);
        Log.e("dsada", subjects.toString());
        Log.e("dsada", mSubjects.toString());
        mSubjectsView.setAdapter(new SubjectModelRecyclerViewAdapter(this, mSubjects));
        mSubjectsView.getAdapter().notifyDataSetChanged();
        mSubjectsView.invalidate();
    }
}
