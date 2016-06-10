package com.clean.presentation.presenters.main;

import com.clean.presentation.presenters.BasePresenter;
import com.clean.presentation.ui.BaseView;

import java.util.List;


public interface MainPresenter extends BasePresenter {

    interface View extends BaseView {
        void displaySubjects(List subjects);
        // TODO: Add your view methods
    }

    // TODO: Add your presenter methods

}
