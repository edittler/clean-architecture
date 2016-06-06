package com.clean.data.mapper;

import com.clean.domain.model.Subject;

import org.json.JSONException;
import org.json.JSONObject;

/**
 * Created by fabrizio on 29/05/16.
 */
public class JsonToSubjectMapper {


    public static Subject transform(JSONObject json) {
        Subject subject = new Subject();
        try {
            subject.setName(json.getString("name"));
            subject.setCode(json.getInt("code"));
            subject.setDepartament(json.getString("departament"));
            return subject;
        } catch (JSONException e) {
            return null;
        }
    }
}
