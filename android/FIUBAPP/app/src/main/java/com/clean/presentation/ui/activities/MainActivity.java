package com.clean.presentation.ui.activities;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.widget.TextView;

import com.clean.R;
import com.clean.data.RestApi;
import com.clean.domain.executor.impl.ThreadExecutor;
import com.clean.domain.repository.StudentRepository;
import com.clean.presentation.presenters.MainPresenter;
import com.clean.presentation.presenters.MainPresenter.View;
import com.clean.presentation.presenters.impl.MainPresenterImpl;
import com.clean.threading.MainThreadImpl;

import org.json.JSONArray;
import org.json.JSONException;
import org.w3c.dom.Text;

import butterknife.ButterKnife;

public class MainActivity extends AppCompatActivity implements View {

    private MainPresenter mPresenter;
    private TextView mProgramsView;

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        mProgramsView = (TextView) findViewById(R.id.programs);
        ButterKnife.bind(this);

        // create a presenter for this view
        mPresenter = new MainPresenterImpl(
                ThreadExecutor.getInstance(),
                MainThreadImpl.getInstance(),
                this
        );
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    protected void onResume() {
        super.onResume();
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
    public void displayDegreePrograms(JSONArray programs) {
        try {
            mProgramsView.setText((String) programs.get(0));
        } catch (JSONException e) {}
    }
}
