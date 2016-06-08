package com.clean.data.repository;

import android.content.Context;
import android.content.SharedPreferences;
import android.util.Log;

import com.clean.data.mapper.JsonToCourseMapper;
import com.clean.data.mapper.JsonToSubjectMapper;
import com.clean.domain.model.Course;
import com.clean.domain.model.DegreeProgram;
import com.clean.domain.model.Subject;
import com.clean.domain.repository.StudentRepository;
import com.colintmiller.simplenosql.NoSQL;
import com.colintmiller.simplenosql.NoSQLEntity;
import com.colintmiller.simplenosql.RetrievalCallback;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.atomic.AtomicBoolean;

/**
 * Created by fabrizio on 07/06/16.
 */
public class LocalDataBase implements StudentRepository {

    private static String SUBJECT_BUCKET = "subjects";
    private static String COURSE_BUCKET = "courses";
    private static String SUBJECT_ID = "subjects";
    private static String COURSE_ID = "courses";


    private Context mContext;
    private AtomicBoolean mRetrieved;

    /**********************************************************************************************/
    /**********************************************************************************************/

    public LocalDataBase(Context context) {
        //deleteSubjects(context);
        deleteCourses(context);
        insertSubjects(context);
        //insertCourses(context);
        mContext = context;
        mRetrieved = new AtomicBoolean(false);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void deleteSubjects(Context context) {
        NoSQL.with(context).using(Subject.class)
                .bucketId(SUBJECT_BUCKET)
                .delete();
    }


    private void deleteCourses(Context context) {
        NoSQL.with(context).using(Subject.class)
                .bucketId(COURSE_BUCKET)
                .delete();
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void insertSubjects(Context context) {
        List<NoSQLEntity<Subject>> subjectList = new ArrayList<>();
        try {
            JSONObject json = new JSONObject(HardCodedResponses.SUBJECTS);
            JSONArray subjects = json.getJSONArray(HardCodedResponses.SUBJECTS_KEY);
            for (int i = 0; i < subjects.length(); i++) {
                JSONObject jsonSubject = subjects.getJSONObject(i);
                Subject subject = JsonToSubjectMapper.transform(jsonSubject);
                Log.e("SUBJECT", subject.getName());
                addCourses(subject);
                NoSQLEntity<Subject> entity = new NoSQLEntity<>(SUBJECT_BUCKET, Integer.toString(subject.getCode()));
                entity.setData(subject);
                subjectList.add(entity);
            }
            NoSQL.with(context).using(Subject.class).save(subjectList);
        } catch (JSONException e) {
            Log.e("ERROR REPO", e.toString());
        }
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void addCourses(Subject subject) {
        List<Course> courseList = new ArrayList<>();
        try {
            JSONObject json = new JSONObject(HardCodedResponses.COURSES);
            JSONArray courses = json.getJSONArray(HardCodedResponses.COURSES_KEY);
            for (int i = 0; i < courses.length(); i++) {
                JSONObject jsonCourse = courses.getJSONObject(i);
                Course course = JsonToCourseMapper.transform(jsonCourse);
                courseList.add(course);
            }
            subject.setCourses(courseList);
        } catch (JSONException e) {
            Log.e("ERROR REPO", e.toString());
        }
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public List<DegreeProgram> getDegreePrograms() {
        return null;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public List<Subject> getAvailableSubjects() {
        final List<Subject> subjects = new ArrayList<>();
        mRetrieved.set(false);

        NoSQL.with(mContext).using(Subject.class)
                .bucketId(SUBJECT_BUCKET)
                .retrieve(new RetrievalCallback<Subject>() {
                    @Override
                    public void retrievedResults(List<NoSQLEntity<Subject>> entities) {
                        // Display results or something
                        Log.e("RETRIEVED", Integer.toString(entities.size()));
                        for (NoSQLEntity<Subject> entity : entities) {
                                subjects.add(entity.getData());
                            Log.e("RETRIEVED", entity.getData().getName());
                        }
                        mRetrieved.set(true);
                        ;
                    }
                });
        waitUntilCondition(mRetrieved);
        Log.e("SUBJECTS", subjects.toString());
        return subjects;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public Map<Integer, Course> getEnrolledCourses() {
        final Map<Integer, Course> courses = new HashMap<>();
        mRetrieved.set(false);
        NoSQL.with(mContext).using(Course.class)
                .bucketId(COURSE_BUCKET)
                .retrieve(new RetrievalCallback<Course>() {
                    @Override
                    public void retrievedResults(List<NoSQLEntity<Course>> entities) {
                        // Display results or something
                        Log.e("RETRIEVED ENR_COURSES", Integer.toString(entities.size()));
                        for (NoSQLEntity<Course> entity : entities) {
                            courses.put(Integer.valueOf(entity.getId()), entity.getData());
                        }
                        mRetrieved.set(true);
                    }
                });
        waitUntilCondition(mRetrieved);
        Log.e("SUBJECTS", courses.toString());
        return courses;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public List<Course> getCourses(int subjectCode) {
        final List<Course> courses = new ArrayList<>();
        mRetrieved.set(false);
        Log.e("GETCOURSES SUBJECT CODE", Integer.toString(subjectCode));

        NoSQL.with(mContext).using(Subject.class)
                .bucketId(SUBJECT_BUCKET)
                .entityId(Integer.toString(subjectCode))
                .retrieve(new RetrievalCallback<Subject>() {
                    @Override
                    public void retrievedResults(List<NoSQLEntity<Subject>> entities) {
                        // Display results or something
                        if (entities.size() == 0) return;
                        Subject subject = entities.get(0).getData();
                        List<Course> courseList = subject.getCourses();
                        for (Course course : courseList) {
                            courses.add(course);
                        }
                        mRetrieved.set(true);
                    }
                });
        waitUntilCondition(mRetrieved);
        return courses;
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public Course getCourse(int subjectCode, final int courseId) {
        final List<Course> courses = new ArrayList<>();
        mRetrieved.set(false);
        Log.e("GET COURSE SUBJECT CODE", Integer.toString(subjectCode));

        NoSQL.with(mContext).using(Subject.class)
                .bucketId(SUBJECT_BUCKET)
                .entityId(Integer.toString(subjectCode))
                .retrieve(new RetrievalCallback<Subject>() {
                    @Override
                    public void retrievedResults(List<NoSQLEntity<Subject>> entities) {
                        // Display results or something
                        if (entities.size() == 0) return;
                        Subject subject = entities.get(0).getData();
                        List<Course> courseList = subject.getCourses();
                        for (Course course : courseList) {
                            if (course.getId().intValue() == courseId) {
                                courses.add(course);
                                break;
                            }
                        }
                        mRetrieved.set(true);
                    }
                });
        waitUntilCondition(mRetrieved);
        return courses.get(0);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public Subject getSubject(int subjectCode) {
        final List<Subject> subjects = new ArrayList<>();
        mRetrieved.set(false);
        Log.e("GET COURSE SUBJECT CODE", Integer.toString(subjectCode));

        NoSQL.with(mContext).using(Subject.class)
                .bucketId(SUBJECT_BUCKET)
                .entityId(Integer.toString(subjectCode))
                .retrieve(new RetrievalCallback<Subject>() {
                    @Override
                    public void retrievedResults(List<NoSQLEntity<Subject>> entities) {
                        // Display results or something
                        if (entities.size() == 0) return;
                        Subject subject = entities.get(0).getData();
                        subjects.add(subject);
                        mRetrieved.set(true);
                    }
                });
        waitUntilCondition(mRetrieved);
        return subjects.get(0);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    @Override
    public void enrollCourse(int subjectCode, Course course) {
        String subjectKey = Integer.toString(subjectCode);
        NoSQLEntity<Course> entity = new NoSQLEntity<>(COURSE_BUCKET, subjectKey);
        entity.setData(course);
        NoSQL.with(mContext).using(Course.class).save(entity);
    }

    /**********************************************************************************************/
    /**********************************************************************************************/

    private void waitUntilCondition(AtomicBoolean condition) {
        while (!condition.get()) {
            try {
                Thread.sleep(500);
                Log.e("WAIT", "waiting");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

}
