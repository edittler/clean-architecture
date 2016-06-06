//
//  ListEnrolledCoursesPresenter.swift
//  FIUBA
//

import Foundation

class ListEnrolledCoursesPresenter: ListEnrolledCoursesInteractorOutput {

    weak var output: ListEnrolledCoursesViewInput!
  
    // MARK: Presentation logic
  
    func presentFetchedEnrolledCourses(response: ListEnrolledCourses.Response) {
        var displayedCourses: [ListEnrolledCourses.ViewModel.DisplayedCourse] = []
        for course in response.courses {
            let displayedCourse = ListEnrolledCourses.ViewModel.DisplayedCourse(
                id: course.id ?? "",
                number: course.number ?? 0,
                teachers: course.teachers ?? "",
                vacancies: course.vacancies ?? 0,
                enrolled: course.enrolled ?? false)
            displayedCourses.append(displayedCourse)
        }
        let viewModel = ListEnrolledCourses.ViewModel(displayedCourses: displayedCourses)
        output.displayFetchedEnrolledCourses(viewModel)
    }

}
