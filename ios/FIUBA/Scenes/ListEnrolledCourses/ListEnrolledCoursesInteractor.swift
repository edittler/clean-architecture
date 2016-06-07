//
//  ListEnrolledCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListEnrolledCoursesInteractorInput {
    func fetchEnrolledCourses(request: ListEnrolledCourses.Request)
    func unenrollCourse(request: ListEnrolledCourses.UnenrollCourse.Request)
}

protocol ListEnrolledCoursesInteractorOutput {
    func presentFetchedEnrolledCourses(response: ListEnrolledCourses.Response)
    func presentUnenrollCourseResult(response: ListEnrolledCourses.UnenrollCourse.Response)
}

protocol ListEnrolledCoursesWorkerProtocol {
    func fetchEnrolledCourses(completionHandler: (courses: [Course]) -> Void)
    func unenrollCourse(id: String)
}

class ListEnrolledCoursesInteractor: ListEnrolledCoursesInteractorInput {

    var output: ListEnrolledCoursesInteractorOutput!
    var worker: ListEnrolledCoursesWorkerProtocol! = ListEnrolledCoursesWorker()

    var enrolledCourses: [Course]?

    // MARK: Business logic
  
    func fetchEnrolledCourses(request: ListEnrolledCourses.Request) {
        worker.fetchEnrolledCourses { (courses) in
            self.enrolledCourses = courses
            let response = ListEnrolledCourses.Response(courses: courses)
            self.output.presentFetchedEnrolledCourses(response)
        }
    }

    func unenrollCourse(request: ListEnrolledCourses.UnenrollCourse.Request) {
        worker.unenrollCourse(request.id)
        output.presentUnenrollCourseResult(ListEnrolledCourses.UnenrollCourse.Response(
            unenrollSuccess: true,
            title: "Desuscripción existosa",
            message: "Se ha desuscripto correctamente del curso."))
    }

}
