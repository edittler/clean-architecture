//
//  ListCoursesPresenter.swift
//  FIUBA
//

import UIKit

protocol ListCoursesPresenterInput {
    func presentFetchedCourses(response: ListCourses.Response)
}

protocol ListCoursesPresenterOutput: class {
    func displayFetchedCourses(viewModel: ListCourses.ViewModel)
}

class ListCoursesPresenter: ListCoursesPresenterInput {

    weak var output: ListCoursesPresenterOutput!

    // MARK: Presentation logic

    func presentFetchedCourses(response: ListCourses.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = ListCourses.ViewModel()
        output.displayFetchedCourses(viewModel)
    }

}
