//
//  ListEnrolledCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListEnrolledCoursesInteractorInput {
    func fetchEnrolledCourses(request: ListEnrolledCourses.Request)
}

protocol ListEnrolledCoursesInteractorOutput {
    func presentFetchedEnrolledCourses(response: ListEnrolledCourses.Response)
}

class ListEnrolledCoursesInteractor: ListEnrolledCoursesInteractorInput {

    var output: ListEnrolledCoursesInteractorOutput!
    var worker: ListEnrolledCoursesWorker! = ListEnrolledCoursesWorker()

    var enrolledCourses: [Course]?

    // MARK: Business logic
  
    func fetchEnrolledCourses(request: ListEnrolledCourses.Request) {
        worker.fetchEnrolledCourses { (courses) in
            self.enrolledCourses = courses
            let response = ListEnrolledCourses.Response(courses: courses)
            self.output.presentFetchedEnrolledCourses(response)
        }
    }

}
