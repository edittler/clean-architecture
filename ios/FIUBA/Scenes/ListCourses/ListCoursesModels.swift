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
            var id: String
            var number: Int
            var teachers: String
            var vacancies: Int
        }

        var displayedCourses: [DisplayedCourse]
    }

    // MARK: - Select Course

    struct SelectCourse {

        struct Request {
            var id: String
        }

        struct Response {
            var course: Course
        }

        struct ViewModel {
            var number: Int
            var teachers: String
            var vacancies: Int
        }

    }

    // MARK: - Enroll Course

    struct EnrollCourse {
    }
}
