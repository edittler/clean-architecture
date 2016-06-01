//
//  ListCoursesPresenter.swift
//  FIUBA
//

import Foundation

class ListCoursesPresenter: ListCoursesInteractorOutput {

    weak var output: ListCoursesViewProtocol!

    // MARK: Presentation logic

    func presentFetchedCourses(response: ListCourses.Response) {
        var displayedCourses: [ListCourses.ViewModel.DisplayedCourse] = []
        for course in response.courses {
            let displayedCourse = ListCourses.ViewModel.DisplayedCourse(
                id: course.id ?? "",
                number: course.number ?? 0,
                teachers: course.teachers ?? "",
                vacancies: course.vacancies ?? 0)
            displayedCourses.append(displayedCourse)
        }
        let viewModel = ListCourses.ViewModel(displayedCourses: displayedCourses)
        output.displayFetchedCourses(viewModel)
    }

    func presentEnrollCourseConfirmation(response: ListCourses.SelectCourse.Response) {
        let viewModel = ListCourses.SelectCourse.ViewModel(
            number: response.course.number ?? 0,
            teachers: response.course.teachers ?? "",
            vacancies: response.course.vacancies ?? 0)
        output.displayEnrollCourseConfirmation(viewModel)
    }

}
