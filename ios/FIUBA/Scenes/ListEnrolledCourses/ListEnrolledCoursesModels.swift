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

    struct UnenrollCourse {

        struct Request {
            var id: String
        }

        struct Response {
            var unenrollSuccess: Bool
            var title: String
            var message: String
        }

        struct ViewModel {
            var unenrollSuccess: Bool
            var title: String
            var message: String
        }
    }

}
