package com.clean.domain.interactors.base;

import org.json.JSONArray;

/**
 * Created by fabrizio on 26/05/16.
 */
public interface ShowDegreePrograms extends Interactor {
    interface Callback {

        void onDegreeProgramsRetrieved(JSONArray programs);

        void onRetrievalFailed(String error);
    }

}
