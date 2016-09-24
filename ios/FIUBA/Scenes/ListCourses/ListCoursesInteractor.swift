//
//  ListCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListCoursesInteractorInput {
    func fetchCourses(_ request: ListCourses.Request)
    func selectCourse(_ request: ListCourses.SelectCourse.Request)
    func enrollCourse(_ request: ListCourses.EnrollCourse.Request)

    var subject: Subject! { get set }
}

protocol ListCoursesInteractorOutput {
    func presentFetchedCourses(_ response: ListCourses.Response)
    func presentEnrollCourseConfirmation(_ response: ListCourses.SelectCourse.Response)
    func presentEnrollCourseResult(_ response: ListCourses.EnrollCourse.Response)
}

protocol ListCoursesWorkerProtocol {
    func fetchCoursesBySubject(_ subject: Subject, completionHandler: (_ courses: [Course]) -> Void)
    func fetchEnrolledCourses(_ completionHandler: (_ courses: [Course]) -> Void)
    func enrollCourse(_ id: String)
}

class ListCoursesInteractor: ListCoursesInteractorInput {

    var output: ListCoursesInteractorOutput!
    var worker: ListCoursesWorkerProtocol!

    var subject: Subject!
    var courses: [Course]?
  
    // MARK: Business logic

    func fetchCourses(_ request: ListCourses.Request) {
        worker.fetchCoursesBySubject(subject) { (courses) in
            self.courses = courses
            let response = ListCourses.Response(courses: courses)
            self.output.presentFetchedCourses(response)
        }
    }

    func selectCourse(_ request: ListCourses.SelectCourse.Request) {
        guard let courses = self.courses else { return }
        guard !courses.isEmpty else { return }

        let index = courses.index { (course) -> Bool in
            return request.id == course.id
        }
        
        guard let aindex = index else { return }
        output.presentEnrollCourseConfirmation(ListCourses.SelectCourse.Response(course: courses[aindex]))
    }

    func enrollCourse(_ request: ListCourses.EnrollCourse.Request) {
        if !isEnrolledCourse() {
            worker.fetchEnrolledCourses({ (courses) in
                if courses.count < 3 {
                    NSLog("Enroll!!")
                    self.enrollCourse(request.id)
                } else {
                    NSLog("Not Enroll :(")
                    self.notEnrollCourse("No se ha podido inscribir. Ya se ha superado el límite de inscripciones.")
                }
            })
        } else {
            NSLog("Not Enroll :(")
            notEnrollCourse("No se ha podido inscribir. Ya se encuentra inscipto en un curso de la asignatura.")
        }
    }

    fileprivate func isEnrolledCourse() -> Bool {
        guard let courses = self.courses else { return false }
        guard !courses.isEmpty else { return false }

        let enrolledCourses = courses.filter { (course) -> Bool in
            return course.enrolled ?? false
        }
        return !enrolledCourses.isEmpty
    }

    fileprivate func enrollCourse(_ id: String) {
        worker.enrollCourse(id)
        output.presentEnrollCourseResult(ListCourses.EnrollCourse.Response(
            enrollSuccess: true,
            title: "Inscripción existosa",
            message: "Se ha inscripto correctamente al curso"))
    }

    fileprivate func notEnrollCourse(_ message: String) {
        output.presentEnrollCourseResult(ListCourses.EnrollCourse.Response(
            enrollSuccess: false,
            title: "Inscripción fallida",
            message: message))
    }

}
