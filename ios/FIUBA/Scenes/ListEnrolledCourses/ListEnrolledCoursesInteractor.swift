//
//  ListEnrolledCoursesInteractor.swift
//  FIUBA
//

import Foundation

protocol ListEnrolledCoursesInteractorInput {
    func doSomething(request: ListEnrolledCourses.Request)
}

protocol ListEnrolledCoursesInteractorOutput {
    func presentSomething(response: ListEnrolledCourses.Response)
}

class ListEnrolledCoursesInteractor: ListEnrolledCoursesInteractorInput {
    var output: ListEnrolledCoursesInteractorOutput!
    var worker: ListEnrolledCoursesWorker!
  
    // MARK: Business logic
  
    func doSomething(request: ListEnrolledCourses.Request) {
        // NOTE: Create some Worker to do the work
    
        worker = ListEnrolledCoursesWorker()
        worker.doSomeWork()
    
        // NOTE: Pass the result to the Presenter
    
        let response = ListEnrolledCourses.Response()
        output.presentSomething(response)
    }

}
