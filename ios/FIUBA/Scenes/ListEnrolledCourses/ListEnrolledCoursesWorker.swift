//
//  ListEnrolledCoursesWorker.swift
//  FIUBA
//

import Foundation

class ListEnrolledCoursesWorker {

    let coursesWorker: CoursesWorker = CoursesWorker(coursesStore: CoursesRealmStore())

    // MARK: Business Logic

    func fetchEnrolledCourses(completionHandler: (courses: [Course]) -> Void) {
        coursesWorker.fetchEnrolledCourses { (result) in
            completionHandler(courses: result)
        }
    }

}
