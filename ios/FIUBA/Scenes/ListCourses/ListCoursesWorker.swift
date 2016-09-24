//
//  ListCoursesWorker.swift
//  FIUBA
//

import Foundation

class ListCoursesWorker: ListCoursesWorkerProtocol {

    let coursesWorker: CoursesWorker = CoursesWorker(coursesStore: CoursesRealmStore())

    // MARK: Business Logic

    func fetchCoursesBySubject(_ subject: Subject, completionHandler: (_ courses: [Course]) -> Void) {
        coursesWorker.fetchCoursesBySubject(subject) { (courses) in
            completionHandler(courses)
        }
    }

    func fetchEnrolledCourses(_ completionHandler: (_ courses: [Course]) -> Void) {
        coursesWorker.fetchEnrolledCourses { (result) in
            completionHandler(result)
        }
    }

    func enrollCourse(_ id: String) {
        coursesWorker.fetchCourse(id) { (course) in
            guard var course = course else { return }
            course.enrolled = true
            if course.vacancies != nil {
                course.vacancies = (course.vacancies! - 1) 
            }
            self.coursesWorker.updateCourse(course)
        }
    }

}
