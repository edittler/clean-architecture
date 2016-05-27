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
        var displayedCourses: [ListCourses.ViewModel.DisplayedCourse] = []
        for course in response.courses {
            let displayedCourse = ListCourses.ViewModel.DisplayedCourse(
                number: course.number ?? 0,
                teachers: course.teachers?.joinWithSeparator(", ") ?? "",
                vacancies: course.vacancies ?? 0)
            displayedCourses.append(displayedCourse)
        }
        let viewModel = ListCourses.ViewModel(displayedCourses: displayedCourses)
        output.displayFetchedCourses(viewModel)
    }

}
