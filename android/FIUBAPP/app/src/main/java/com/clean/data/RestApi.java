package com.clean.data;

import com.clean.domain.model.Course;
import com.clean.domain.model.DegreeProgram;
import com.clean.domain.model.Subject;
import com.clean.domain.repository.StudentRepository;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by fabrizio on 26/05/16.
 */
public class RestApi implements StudentRepository {
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
    public List<Subject> getAvailableSubjects(String degreeName) {
        return null;
    }

    @Override
    public List<DegreeProgram> getEnrolledCourses(int subjectCode) {
        return null;
    }

    @Override
    public Course getCourse(int subjectCode, int courseId) {
        return null;
    }
}
