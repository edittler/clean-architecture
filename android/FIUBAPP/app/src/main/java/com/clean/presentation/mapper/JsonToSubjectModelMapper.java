package com.clean.presentation.mapper;

import android.util.Log;

import com.clean.domain.model.Subject;
import com.clean.presentation.model.SubjectModel;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by fabrizio on 31/05/16.
 */
public class JsonToSubjectModelMapper {

    public static List<SubjectModel> transform(List<Subject> subjects) {
        List<SubjectModel> subjectList = new ArrayList<>();
//        try {
            for (Subject subject : subjects) {
            /*for (int i = 0; i < subjects.size(); i++) {
                JSONObject subjectObject = subjects.getJSONObject(i);
                String name = subjectObject.getString("name");
                int code = subjectObject.getInt("code");
                SubjectModel model = SubjectModel.buildSubjectModel().addName(name).addCode(code);
                subjectList.add(model);*/
                subjectList.add(SubjectModel.buildSubjectModel().
                        addName(subject.getName()).
                        addCode(subject.getCode()));
            }

//        } catch (JSONException e) {
//            Log.e("VIEW_PARSE_ERROR", e.toString());
//        }
        return subjectList;
    }
}
