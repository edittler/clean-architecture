//
//  ListCoursesModels.swift
//  FIUBA
//

import UIKit

struct ListCourses {

    struct Request {
    }

    struct Response {
        var courses: [Course]
    }

    struct ViewModel {

        struct DisplayedCourse {
            var number: Int
            var teachers: String
            var vacancies: Int
        }

        var displayedCourses: [DisplayedCourse]
    }

}
