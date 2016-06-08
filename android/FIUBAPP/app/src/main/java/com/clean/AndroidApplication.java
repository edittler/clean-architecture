package com.clean;

import android.app.Application;

import com.clean.presentation.UniquePointOfInstanciation;

import timber.log.Timber;
import timber.log.Timber.DebugTree;

public class AndroidApplication extends Application {
    @Override
    public void onCreate() {
        UniquePointOfInstanciation.setContext(getApplicationContext());
        super.onCreate();
        // initiate Timber
        Timber.plant(new DebugTree());
    }
}
