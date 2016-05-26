package com.clean.presentation.presenters;

import com.clean.presentation.presenters.base.BasePresenter;
import com.clean.presentation.ui.BaseView;

import org.json.JSONArray;


public interface MainPresenter extends BasePresenter {

    interface View extends BaseView {
        void displayDegreePrograms(JSONArray programs);
        // TODO: Add your view methods
    }

    // TODO: Add your presenter methods

}
