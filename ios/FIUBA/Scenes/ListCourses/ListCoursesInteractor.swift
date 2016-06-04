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

class ListCoursesInteractor: ListCoursesInteractorInput {

    var output: ListCoursesInteractorOutput!
    var worker: ListCoursesWorker! = ListCoursesWorker()

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
            NSLog("Enroll!!")
            worker.enrollCourse(request.id)
            output.presentEnrollCourseResult(ListCourses.EnrollCourse.Response(
                enrollSuccess: true,
                title: "Inscripción existosa",
                message: "Se ha inscripto correctamente al curso"))
        } else {
            NSLog("Not Enroll :(")
            output.presentEnrollCourseResult(ListCourses.EnrollCourse.Response(
                enrollSuccess: false,
                title: "Inscripción fallida",
                message: "No se ha podido inscribir. Ya se encuentra inscipto en un curso de la asignatura."))
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

}
