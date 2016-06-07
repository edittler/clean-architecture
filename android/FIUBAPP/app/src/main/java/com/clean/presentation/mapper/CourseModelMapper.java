package com.clean.presentation.mapper;

import com.clean.domain.model.Course;
import com.clean.presentation.model.CourseModel;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by fabrizio on 06/06/16.
 */
public class CourseModelMapper {

    public static List<CourseModel> transform(List<Course> courses) {
        List<CourseModel> courseList = new ArrayList<>();
        for (Course course : courses) {
            courseList.add(CourseModel.buildCourseModel().
                    addTeachers(course.getTeachers()).
                    addId(course.getId()).
                    addClassroom(course.getClassroom()).
                    addSchedule(course.getSchedule()).
                    addVacancy(course.getVacancy())
            );
        }
        return courseList;
    }

    public static List<String> transformToStrings(List<Course> courses) {
        List<String> courseList = new ArrayList<>();
        for (Course course : courses) {
            courseList.add(Integer.toString(course.getId()));
        }
        return courseList;
    }

}
