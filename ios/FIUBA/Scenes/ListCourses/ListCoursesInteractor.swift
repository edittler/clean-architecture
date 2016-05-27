//
//  ListCoursesInteractor.swift
//  FIUBA
//

import UIKit

protocol ListCoursesInteractorInput {
    func fetchCourses(request: ListCourses.Request)
}

protocol ListCoursesInteractorOutput {
    func presentFetchedCourses(response: ListCourses.Response)
}

class ListCoursesInteractor: ListCoursesInteractorInput {

    var output: ListCoursesInteractorOutput!
    var worker: ListCoursesWorker!
    var coursesWorker: CoursesWorker = CoursesWorker()
  
    // MARK: Business logic

    func fetchCourses(request: ListCourses.Request) {
        coursesWorker.fetchCourses { (courses) in
            let response = ListCourses.Response(courses: courses)
            self.output.presentFetchedCourses(response)
        }
    }

}
