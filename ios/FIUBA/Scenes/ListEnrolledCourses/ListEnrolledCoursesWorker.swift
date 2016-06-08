//
//  ListEnrolledCoursesWorker.swift
//  FIUBA
//

import Foundation

class ListEnrolledCoursesWorker: ListEnrolledCoursesWorkerProtocol {

    let coursesWorker: CoursesWorker = CoursesWorker(coursesStore: CoursesRealmStore())

    // MARK: Business Logic

    func fetchEnrolledCourses(completionHandler: (courses: [Course]) -> Void) {
        coursesWorker.fetchEnrolledCourses { (result) in
            completionHandler(courses: result)
        }
    }

    func unenrollCourse(id: String) {
        coursesWorker.fetchCourse(id) { (course) in
            guard var course = course else { return }
            course.enrolled = false
            if course.vacancies != nil {
                course.vacancies = (course.vacancies! + 1) ?? 0
            }
            self.coursesWorker.updateCourse(course)
        }
    }

}
