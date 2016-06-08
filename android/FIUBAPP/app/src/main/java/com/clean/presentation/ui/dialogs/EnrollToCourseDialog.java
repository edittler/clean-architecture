package com.clean.presentation.ui.dialogs;


import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;

import com.clean.R;
import com.clean.presentation.ui.activities.EnrollToCourseActivity;

/**
 * Created by fabrizio on 06/06/16.
 */
public class EnrollToCourseDialog {


    private EnrollToCourseDialog() {}

    public static AlertDialog build(final Context context, String courseInfo,
                                    final int id, final int subjectCode) {

        return new AlertDialog.Builder(context)
                .setTitle(R.string.enroll_title)
                .setMessage(courseInfo)
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        Intent intent = new Intent(context, EnrollToCourseActivity.class);
                        intent.putExtra(EnrollToCourseActivity.COURSE_ID, id);
                        intent.putExtra(EnrollToCourseActivity.SUBJECT_CODE, subjectCode);
                        context.startActivity(intent);
                    }
                })
                .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // do nothing
                    }
                })
                .setCancelable(false)
                .create();
    }
}
