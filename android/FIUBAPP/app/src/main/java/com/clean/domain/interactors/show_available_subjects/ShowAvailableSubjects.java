package com.clean.domain.interactors.show_available_subjects;

import com.clean.domain.interactors.Interactor;

import org.json.JSONArray;

import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */
public interface ShowAvailableSubjects extends Interactor {

    interface Callback {

        void onSubjectsRetrieved(List subjects);

        void onRetrievalFailed(String error);
    }
}
