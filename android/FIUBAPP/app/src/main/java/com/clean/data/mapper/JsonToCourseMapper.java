package com.clean.data.mapper;

import com.clean.domain.model.Course;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by fabrizio on 31/05/16.
 */
public class JsonToCourseMapper {

    public static Course transform(JSONObject json) {
        Course course = new Course();
        try {
            course.setId(json.getInt("id"));
            JSONArray teachers = json.getJSONArray("teachers");
            List<String> teacherList = new ArrayList<>();
            for (int i = 0; i < teachers.length(); i++) {
                teacherList.add(teachers.getString(i));
            }
            course.setTeachers(teacherList);
            course.setSchedule(json.getString("schedule"));
            course.setClassroom(json.getString("classroom"));
            course.setVacancy(json.getInt("vacancy"));
            return course;
        } catch (JSONException e) {
            return null;
        }
    }
}
