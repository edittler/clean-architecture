//
//  ListCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListCoursesInteractorInput {
    func fetchCourses(request: ListCourses.Request)
    func selectCourse(request: ListCourses.SelectCourse.Request)
}

protocol ListCoursesInteractorOutput {
    func presentFetchedCourses(response: ListCourses.Response)
    func presentEnrollCourseConfirmation(response: ListCourses.SelectCourse.Response)
}

class ListCoursesInteractor: ListCoursesInteractorInput {

    var output: ListCoursesInteractorOutput!
    var worker: ListCoursesWorker!
    var coursesWorker: CoursesWorker = CoursesWorker(coursesStore: CoursesRealmStore())
    var courses: [Course]?
  
    // MARK: Business logic

    func fetchCourses(request: ListCourses.Request) {
        coursesWorker.fetchCourses { (courses) in
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

}
