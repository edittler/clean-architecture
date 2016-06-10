package com.clean.presentation.ui.activities;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.clean.R;
import butterknife.ButterKnife;

public class Main2Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);
        ButterKnife.bind(this);

        Button seeEnrolled = (Button) findViewById(R.id.see_enrolled);
        Button enroll = (Button) findViewById(R.id.enroll);
        setSeeEnrolledBehavior(seeEnrolled);
        setEnrollBehavior(enroll);

    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void setSeeEnrolledBehavior(Button seeEnrolled) {
        seeEnrolled.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Main2Activity.this, EnrolledCoursesActivity.class);
                startActivity(intent);
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void setEnrollBehavior(Button enroll) {
        enroll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Main2Activity.this, MainActivity.class);
                startActivity(intent);
            }
        });
    }
}
