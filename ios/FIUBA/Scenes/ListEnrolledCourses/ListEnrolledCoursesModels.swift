//
//  ListEnrolledCoursesModels.swift
//  FIUBA
//

import Foundation

struct ListEnrolledCourses {

    struct Request {
    }

    struct Response {
        var courses: [Course]
    }

    struct ViewModel {

        struct DisplayedCourse {
            var id: String
            var number: Int
            var teachers: String
            var vacancies: Int
            var enrolled: Bool
        }

        var displayedCourses: [DisplayedCourse]
    }

}
