package com.clean.domain.interactors.show_available_subjects;

import com.clean.domain.executor.Executor;
import com.clean.domain.executor.MainThread;
import com.clean.domain.interactors.AbstractInteractor;
import com.clean.domain.model.Subject;
import com.clean.domain.repository.StudentRepository;
import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */
public class ShowAvailableSubjectsImpl extends AbstractInteractor implements ShowAvailableSubjects {

    StudentRepository mRepository;
    ShowAvailableSubjects.Callback mCallback;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public ShowAvailableSubjectsImpl(Executor threadExecutor, MainThread mainThread,
                                 ShowAvailableSubjects.Callback callback, StudentRepository repo) {
        super(threadExecutor, mainThread);
        mRepository = repo;
        mCallback = callback;
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

    private void postSubjects(final List subjects) {
        mMainThread.post(new Runnable() {
            @Override
            public void run() {
                mCallback.onSubjectsRetrieved(subjects);
            }
        });
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void run() {
        // retrieve the message
        final List<Subject> subjects = mRepository.getAvailableSubjects();

        // check if we have failed to retrieve our message
        if (subjects == null || subjects.size() == 0) {
            // notify the failure on the main thread
            notifyError();
            return;
        }

        // we have retrieved our message, notify the UI on the main thread
        postSubjects(subjects);
    }

}
