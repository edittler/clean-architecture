//
//  ListCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListCoursesInteractorInput {
    func fetchCourses(request: ListCourses.Request)
    func selectCourse(request: ListCourses.SelectCourse.Request)
    func enrollCourse(request: ListCourses.EnrollCourse.Request)

    var subject: Subject! { get set }
}

protocol ListCoursesInteractorOutput {
    func presentFetchedCourses(response: ListCourses.Response)
    func presentEnrollCourseConfirmation(response: ListCourses.SelectCourse.Response)
    func presentEnrollCourseResult(response: ListCourses.EnrollCourse.Response)
}

protocol ListCoursesWorkerProtocol {
    func fetchCoursesBySubject(subject: Subject, completionHandler: (courses: [Course]) -> Void)
    func fetchEnrolledCourses(completionHandler: (courses: [Course]) -> Void)
    func enrollCourse(id: String)
}

class ListCoursesInteractor: ListCoursesInteractorInput {

    var output: ListCoursesInteractorOutput!
    var worker: ListCoursesWorkerProtocol!

    var subject: Subject!
    var courses: [Course]?
  
    // MARK: Business logic

    func fetchCourses(request: ListCourses.Request) {
        worker.fetchCoursesBySubject(subject) { (courses) in
            self.courses = courses
            let response = ListCourses.Response(courses: courses)
            self.output.presentFetchedCourses(response)
        }
    }

    func selectCourse(request: ListCourses.SelectCourse.Request) {
        guard let courses = self.courses else { return }
        guard !courses.isEmpty else { return }

        let index = courses.indexOf { (course) -> Bool in
            return request.id == course.id
        }
        
        guard let aindex = index else { return }
        output.presentEnrollCourseConfirmation(ListCourses.SelectCourse.Response(course: courses[aindex]))
    }

    func enrollCourse(request: ListCourses.EnrollCourse.Request) {
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

    private func isEnrolledCourse() -> Bool {
        guard let courses = self.courses else { return false }
        guard !courses.isEmpty else { return false }

        let enrolledCourses = courses.filter { (course) -> Bool in
            return course.enrolled ?? false
        }
        return !enrolledCourses.isEmpty
    }

    private func enrollCourse(id: String) {
        worker.enrollCourse(id)
        output.presentEnrollCourseResult(ListCourses.EnrollCourse.Response(
            enrollSuccess: true,
            title: "Inscripción existosa",
            message: "Se ha inscripto correctamente al curso"))
    }

    private func notEnrollCourse(message: String) {
        output.presentEnrollCourseResult(ListCourses.EnrollCourse.Response(
            enrollSuccess: false,
            title: "Inscripción fallida",
            message: message))
    }

}
