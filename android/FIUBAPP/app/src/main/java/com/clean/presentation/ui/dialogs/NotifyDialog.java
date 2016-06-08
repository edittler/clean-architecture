package com.clean.presentation.ui.dialogs;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AppCompatActivity;

import com.clean.R;
import com.clean.presentation.ui.activities.EnrollToCourseActivity;

/**
 * Created by fabrizio on 08/06/16.
 */
public class NotifyDialog {


    private NotifyDialog() {}

    public static AlertDialog build(final AppCompatActivity context, String title, String message) {

        return new AlertDialog.Builder(context)
                .setTitle(title)
                .setMessage(message)
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        context.finish();
                    }
                })
                .setCancelable(false)
                .create();
    }

}
