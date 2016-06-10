package com.clean.presentation.mapper;

import com.clean.domain.model.Subject;
import com.clean.presentation.model.SubjectModel;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by fabrizio on 31/05/16.
 */
public class SubjectModelMapper {

    public static List<SubjectModel> transform(List<Subject> subjects) {
        List<SubjectModel> subjectList = new ArrayList<>();
        for (Subject subject : subjects) {
            subjectList.add(SubjectModel.buildSubjectModel().
                    addName(subject.getName()).
                    addCode(subject.getCode()));
        }
        return subjectList;
    }
}
