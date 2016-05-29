//
//  ListEnrolledCoursesPresenter.swift
//  FIUBA
//

import Foundation

class ListEnrolledCoursesPresenter: ListEnrolledCoursesInteractorOutput {

    weak var output: ListEnrolledCoursesViewInput!
  
    // MARK: Presentation logic
  
    func presentSomething(response: ListEnrolledCourses.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = ListEnrolledCourses.ViewModel()
        output.displaySomething(viewModel)
    }

}
