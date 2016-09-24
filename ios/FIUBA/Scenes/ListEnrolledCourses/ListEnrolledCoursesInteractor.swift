//
//  ListEnrolledCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListEnrolledCoursesInteractorInput {
    func fetchEnrolledCourses(_ request: ListEnrolledCourses.Request)
    func unenrollCourse(_ request: ListEnrolledCourses.UnenrollCourse.Request)
}

protocol ListEnrolledCoursesInteractorOutput {
    func presentFetchedEnrolledCourses(_ response: ListEnrolledCourses.Response)
    func presentUnenrollCourseResult(_ response: ListEnrolledCourses.UnenrollCourse.Response)
}

protocol ListEnrolledCoursesWorkerProtocol {
    func fetchEnrolledCourses(_ completionHandler: (_ courses: [Course]) -> Void)
    func unenrollCourse(_ id: String)
}

class ListEnrolledCoursesInteractor: ListEnrolledCoursesInteractorInput {

    var output: ListEnrolledCoursesInteractorOutput!
    var worker: ListEnrolledCoursesWorkerProtocol! = ListEnrolledCoursesWorker()

    var enrolledCourses: [Course]?

    // MARK: Business logic
  
    func fetchEnrolledCourses(_ request: ListEnrolledCourses.Request) {
        worker.fetchEnrolledCourses { (courses) in
            self.enrolledCourses = courses
            let response = ListEnrolledCourses.Response(courses: courses)
            self.output.presentFetchedEnrolledCourses(response)
        }
    }

    func unenrollCourse(_ request: ListEnrolledCourses.UnenrollCourse.Request) {
        worker.unenrollCourse(request.id)
        output.presentUnenrollCourseResult(ListEnrolledCourses.UnenrollCourse.Response(
            unenrollSuccess: true,
            title: "Desuscripción existosa",
            message: "Se ha desuscripto correctamente del curso."))
    }

}
