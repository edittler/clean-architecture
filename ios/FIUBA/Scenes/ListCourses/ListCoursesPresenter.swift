//
//  ListCoursesPresenter.swift
//  FIUBA
//

import UIKit

protocol ListCoursesPresenterInput {
    func presentFetchedCourses(response: ListCourses.Response)
    func presentEnrollCourseConfirmation(response: ListCourses.SelectCourse.Response)
}

protocol ListCoursesPresenterOutput: class {
    func displayFetchedCourses(viewModel: ListCourses.ViewModel)
    func displayEnrollCourseConfirmation(viewModel: ListCourses.SelectCourse.ViewModel)
}

class ListCoursesPresenter: ListCoursesPresenterInput {

    weak var output: ListCoursesPresenterOutput!

    // MARK: Presentation logic

    func presentFetchedCourses(response: ListCourses.Response) {
        var displayedCourses: [ListCourses.ViewModel.DisplayedCourse] = []
        for course in response.courses {
            let displayedCourse = ListCourses.ViewModel.DisplayedCourse(
                id: course.id ?? "",
                number: course.number ?? 0,
                teachers: course.teachers?.joinWithSeparator(", ") ?? "",
                vacancies: course.vacancies ?? 0)
            displayedCourses.append(displayedCourse)
        }
        let viewModel = ListCourses.ViewModel(displayedCourses: displayedCourses)
        output.displayFetchedCourses(viewModel)
    }

    func presentEnrollCourseConfirmation(response: ListCourses.SelectCourse.Response) {
        let viewModel = ListCourses.SelectCourse.ViewModel(
            number: response.course.number ?? 0,
            teachers: response.course.teachers?.joinWithSeparator(", ") ?? "",
            vacancies: response.course.vacancies ?? 0)
        output.displayEnrollCourseConfirmation(viewModel)
    }

}
