//
//  CoursesWorker.swift
//  FIUBA
//

import Foundation

class CoursesWorker {

    // MARK: Business Logic

    func fetchCourses(completionHandler: (courses: [Course]) -> Void) {
        var courses: [Course] = []
        courses.append(Course(id: "750901", number: 1, teachers: ["Gonzalez"], vacancies: 90))
        courses.append(Course(id: "750903", number: 3, teachers: ["Villagra"], vacancies: 10))
        completionHandler(courses: courses)
    }

}
