package com.clean.presentation.ui;


import android.content.Context;
import android.content.DialogInterface;
import android.support.v7.app.AlertDialog;

import com.clean.R;

/**
 * Created by fabrizio on 06/06/16.
 */
public class EnrollToCourseDialog {


    private EnrollToCourseDialog() {}

    public static AlertDialog build(Context context, String courseInfo) {

        return new AlertDialog.Builder(context)
                .setTitle(R.string.enroll_title)
                .setMessage(courseInfo)
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // continue with delete
                    }
                })
                .setNegativeButton(android.R.string.no, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        // do nothing
                    }
                })
                .create();
    }
}
