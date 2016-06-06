//
//  ListCoursesWorker.swift
//  FIUBA
//

import Foundation

class ListCoursesWorker {

    let coursesWorker: CoursesWorker = CoursesWorker(coursesStore: CoursesRealmStore())

    // MARK: Business Logic

    func fetchCoursesBySubject(subject: Subject, completionHandler: (courses: [Course]) -> Void) {
        coursesWorker.fetchCoursesBySubject(subject) { (courses) in
            completionHandler(courses: courses)
        }
    }

    func enrollCourse(id: String) {
        coursesWorker.fetchCourse(id) { (course) in
            guard var course = course else { return }
            course.enrolled = true
            if course.vacancies != nil {
                course.vacancies = (course.vacancies! - 1) ?? 0
            }
            self.coursesWorker.updateCourse(course)
        }
    }

}
