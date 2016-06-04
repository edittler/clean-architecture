//
//  ListCoursesModels.swift
//  FIUBA
//

import Foundation

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
            var enrolled: Bool
        }

        var displayedCourses: [DisplayedCourse]
    }

    struct AlertViewModel {
        var title: String
        var message: String
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
            var id: String
            var number: Int
            var teachers: String
            var vacancies: Int
        }

    }

    // MARK: - Enroll Course

    struct EnrollCourse {

        struct Request {
            var id: String
        }

        struct Response {
            var enrollSuccess: Bool
            var title: String
            var message: String
        }

        struct ViewModel {
            var enrollSuccess: Bool
            var title: String
            var message: String
        }

    }

}
