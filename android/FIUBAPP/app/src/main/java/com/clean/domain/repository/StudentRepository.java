/**
 * Copyright (C) 2015 Fernando Cejas Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.clean.domain.repository;

import com.clean.domain.model.Course;
import com.clean.domain.model.DegreeProgram;
import com.clean.domain.model.Student;
import com.clean.domain.model.Subject;

import java.util.List;


/**
 * Interface that represents a Repository for getting {@link Student} related data.
 */
public interface StudentRepository {

    /**
     * Get a List of {@link DegreeProgram}.
     */
    List<DegreeProgram> getDegreePrograms();

    /**
     * Get a List of {@link Subject}.
     * @param degreeName The degree program name used to retrieve the subjects of the program.
     */
    List<Subject> getAvailableSubjects(final String degreeName);

    /**
     * Get a List of {@link DegreeProgram}.
     * @param subjectCode The subject code used to retrieve the courses of the subject.
     */
    List<DegreeProgram> getEnrolledCourses(final int subjectCode);

    /**
     * Get a {@link Course}.
     * @param subjectCode The subject code used to retrieve the courses of the subject.
     * @param courseId The course id used to retrieve the course.
     */
    Course getCourse(final int subjectCode, final int courseId);
}