//
//  CoursesWorker.swift
//  FIUBA
//

import Foundation

class CoursesWorker {

    var coursesStore: CoursesStoreProtocol

    init(coursesStore: CoursesStoreProtocol) {
        self.coursesStore = coursesStore
    }

    func fetchCourses(_ completionHandler: @escaping (_ courses: [Course]) -> Void) {
        coursesStore.fetchCourses { (result) in
            switch result {
            case .success(let courses):
                completionHandler(courses)
            case .failure( _):
                completionHandler([])
            }
        }
    }

    func fetchCoursesBySubject(_ subject: Subject, completionHandler: (_ courses: [Course]) -> Void) {
        coursesStore.fetchCoursesBySubject(subject) { (result) in
            switch result {
            case .success(let courses):
                completionHandler(courses)
            case .failure( _):
                completionHandler([])
            }
        }
    }

    func fetchEnrolledCourses(_ completionHandler: (_ courses: [Course]) -> Void) {
        coursesStore.fetchEnrolledCourses { (result) in
            switch result {
            case .success(let courses):
                completionHandler(courses)
            case .failure( _):
                completionHandler([])
            }
        }
    }

    func fetchCourse(_ id: String, completionHandler: (_ course: Course?) -> Void) {
        coursesStore.fetchCourse(id) { (result) in
            switch result {
            case .success(let course):
                completionHandler(course)
            case .failure( _):
                completionHandler(nil)
            }
        }
    }

    func createCourses(_ coursesToCreate: [Course]) {
        coursesStore.createCourses(coursesToCreate) { (result) in
        }
    }

    func updateCourse(_ courseToUpdate: Course) {
        coursesStore.updateCourse(courseToUpdate) { (result) in
            debugPrint(result)
        }
    }

}

protocol CoursesStoreProtocol {

    // MARK: CRUD operations - Generic enum result type

    func fetchCourses(_ completionHandler: @escaping CoursesStoreFetchCoursesCompletionHandler)
    func fetchCoursesBySubject(_ subject: Subject, completionHandler: CoursesStoreFetchCoursesCompletionHandler)
    func fetchEnrolledCourses(_ completionHandler: CoursesStoreFetchCoursesCompletionHandler)
    func fetchCourse(_ id: String, completionHandler: CoursesStoreFetchCourseCompletionHandler)
    func createCourse(_ courseToCreate: Course, completionHandler: CoursesStoreCreateCourseCompletionHandler)
    func createCourses(_ coursesToCreate: [Course], completionHandler: CoursesStoreCreateCoursesCompletionHandler)
    func updateCourse(_ courseToUpdate: Course, completionHandler: CoursesStoreUpdateCourseCompletionHandler)
    func deleteCourse(_ id: String, completionHandler: CoursesStoreDeleteCourseCompletionHandler)

}

// MARK: - Courses store CRUD operation results

typealias CoursesStoreFetchCoursesCompletionHandler = (_ result: CoursesStoreResult<[Course]>) -> Void
typealias CoursesStoreFetchCourseCompletionHandler = (_ result: CoursesStoreResult<Course>) -> Void
typealias CoursesStoreCreateCourseCompletionHandler = (_ result: CoursesStoreResult<Void>) -> Void
typealias CoursesStoreCreateCoursesCompletionHandler = (_ result: CoursesStoreResult<Void>) -> Void
typealias CoursesStoreUpdateCourseCompletionHandler = (_ result: CoursesStoreResult<Void>) -> Void
typealias CoursesStoreDeleteCourseCompletionHandler = (_ result: CoursesStoreResult<Void>) -> Void

enum CoursesStoreResult<U> {
    case success(result: U)
    case failure(error: CoursesStoreError)
}

// MARK: - Courses store CRUD operation errors

enum CoursesStoreError: Equatable, Error {
    case cannotFetch(String)
    case cannotCreate(String)
    case cannotUpdate(String)
    case cannotDelete(String)
}

func==(lhs: CoursesStoreError, rhs: CoursesStoreError) -> Bool {
    switch (lhs, rhs) {
        case (.cannotFetch(let a), .cannotFetch(let b)) where a == b: return true
        case (.cannotCreate(let a), .cannotCreate(let b)) where a == b: return true
        case (.cannotUpdate(let a), .cannotUpdate(let b)) where a == b: return true
        case (.cannotDelete(let a), .cannotDelete(let b)) where a == b: return true
        default: return false
    }
}
