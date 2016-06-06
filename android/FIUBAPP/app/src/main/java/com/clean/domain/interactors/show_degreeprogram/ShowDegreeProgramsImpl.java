package com.clean.domain.interactors.show_degreeprogram;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.AbstractInteractor;
import com.clean.domain.model.DegreeProgram;
import com.clean.domain.repository.StudentRepository;

import org.json.JSONArray;

import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ShowDegreeProgramsImpl extends AbstractInteractor implements ShowDegreePrograms {

    StudentRepository mRepository;
    ShowDegreePrograms.Callback mCallback;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public ShowDegreeProgramsImpl(Executor threadExecutor, MainThread mainThread,
                                  ShowDegreePrograms.Callback callback, StudentRepository repo) {
        super(threadExecutor, mainThread);
        mCallback = callback;
        mRepository = repo;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void notifyError() {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onRetrievalFailed("Nothing to welcome you with :(");
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void postDegreePrograms(final JSONArray degreePrograms) {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onDegreeProgramsRetrieved(degreePrograms);
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void run() {
        // retrieve the message
        final List<DegreeProgram> programs = mRepository.getDegreePrograms();

        // check if we have failed to retrieve our message
        if (programs == null || programs.size() == 0) {
            // notify the failure on the main thread
            notifyError();
            return;
        }

        JSONArray programNames = new JSONArray();
        for (DegreeProgram program : programs) {
            programNames.put(program.getCollegeDegree());
        }

        // we have retrieved our message, notify the UI on the main thread
        postDegreePrograms(programNames);
    }
}
