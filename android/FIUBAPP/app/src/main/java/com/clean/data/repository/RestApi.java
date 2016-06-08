package com.clean.data.repository;

import android.util.Log;

import com.clean.data.mapper.JsonToCourseMapper;
import com.clean.data.mapper.JsonToSubjectMapper;
import com.clean.domain.model.Course;
import com.clean.domain.model.DegreeProgram;
import com.clean.domain.model.Subject;
import com.clean.domain.repository.StudentRepository;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by fabrizio on 26/05/16.
 */
public class RestApi implements StudentRepository {

    private static List<Subject> subjectList;

    @Override
    public List<DegreeProgram> getDegreePrograms() {
        List<DegreeProgram> programs = new ArrayList<>(); // let's be friendly
        DegreeProgram program = new DegreeProgram("Ing. en Informatica");
        programs.add(program);

        // let's simulate some network/database lag
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return programs;
    }

    @Override
    public List<Subject> getAvailableSubjects() {
        subjectList = new ArrayList<>();
        try {
            JSONObject json = new JSONObject(HardCodedResponses.SUBJECTS);
            JSONArray subjects = json.getJSONArray(HardCodedResponses.SUBJECTS_KEY);
            for (int i = 0; i < subjects.length(); i++) {
                JSONObject jsonSubject = subjects.getJSONObject(i);
                subjectList.add(JsonToSubjectMapper.transform(jsonSubject));
            }
        } catch (JSONException e) {
            Log.e("ERROR REPO", e.toString());
        }

        // let's simulate some network/database lag
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Log.i("List", subjectList.toString());
        return subjectList;
    }

    @Override
    public Map<Integer, Course> getEnrolledCourses() {
        return null;
    }

    @Override
    public Subject getSubject(int subjectCode) {
        for (Subject subject : subjectList) {
            if (subject.getCode() == subjectCode) {
                return subject;
            }
        }
        return null;
    }

    @Override
    public void enrollCourse(int subjectCode, Course course) {

    }

    @Override
    public List<Course> getCourses(int subjectCode) {



        List<Course> courseList = new ArrayList<>();
        try {
            JSONObject json = new JSONObject(HardCodedResponses.COURSES);
            JSONArray courses = json.getJSONArray(HardCodedResponses.COURSES_KEY);
            for (int i = 0; i < courses.length(); i++) {
                JSONObject jsonCourse = courses.getJSONObject(i);
                courseList.add(JsonToCourseMapper.transform(jsonCourse));
            }
            Subject subject = getSubject(subjectCode);
            subject.setCourses(courseList);
        } catch (JSONException e) {
            Log.e("ERROR REPO", e.toString());
        }

        // let's simulate some network/database lag
        try {
            Thread.sleep(2000);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        Log.i("List", courseList.toString());
        return courseList;
    }

    @Override
    public Course getCourse(int subjectCode, int courseId) {
        return null;
    }

}
