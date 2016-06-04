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

    func fetchCourses(completionHandler: (courses: [Course]) -> Void) {
        coursesStore.fetchCourses { (result) in
            switch result {
            case .Success(let courses):
                completionHandler(courses: courses)
            case .Failure( _):
                completionHandler(courses: [])
            }
        }
    }

    func fetchCoursesBySubject(subject: Subject, completionHandler: (courses: [Course]) -> Void) {
        coursesStore.fetchCoursesBySubject(subject) { (result) in
            switch result {
            case .Success(let courses):
                completionHandler(courses: courses)
            case .Failure( _):
                completionHandler(courses: [])
            }
        }
    }

    func fetchCourse(id: String, completionHandler: (course: Course?) -> Void) {
        coursesStore.fetchCourse(id) { (result) in
            switch result {
            case .Success(let course):
                completionHandler(course: course)
            case .Failure( _):
                completionHandler(course: nil)
            }
        }
    }

    func createCourses(coursesToCreate: [Course]) {
        coursesStore.createCourses(coursesToCreate) { (result) in
        }
    }

    func updateCourse(courseToUpdate: Course) {
        coursesStore.updateCourse(courseToUpdate) { (result) in
            debugPrint(result)
        }
    }

}

protocol CoursesStoreProtocol {

    // MARK: CRUD operations - Generic enum result type

    func fetchCourses(completionHandler: CoursesStoreFetchCoursesCompletionHandler)
    func fetchCoursesBySubject(subject: Subject, completionHandler: CoursesStoreFetchCoursesCompletionHandler)
    func fetchCourse(id: String, completionHandler: CoursesStoreFetchCourseCompletionHandler)
    func createCourse(courseToCreate: Course, completionHandler: CoursesStoreCreateCourseCompletionHandler)
    func createCourses(coursesToCreate: [Course], completionHandler: CoursesStoreCreateCoursesCompletionHandler)
    func updateCourse(courseToUpdate: Course, completionHandler: CoursesStoreUpdateCourseCompletionHandler)
    func deleteCourse(id: String, completionHandler: CoursesStoreDeleteCourseCompletionHandler)

}

// MARK: - Courses store CRUD operation results

typealias CoursesStoreFetchCoursesCompletionHandler = (result: CoursesStoreResult<[Course]>) -> Void
typealias CoursesStoreFetchCourseCompletionHandler = (result: CoursesStoreResult<Course>) -> Void
typealias CoursesStoreCreateCourseCompletionHandler = (result: CoursesStoreResult<Void>) -> Void
typealias CoursesStoreCreateCoursesCompletionHandler = (result: CoursesStoreResult<Void>) -> Void
typealias CoursesStoreUpdateCourseCompletionHandler = (result: CoursesStoreResult<Void>) -> Void
typealias CoursesStoreDeleteCourseCompletionHandler = (result: CoursesStoreResult<Void>) -> Void

enum CoursesStoreResult<U> {
    case Success(result: U)
    case Failure(error: CoursesStoreError)
}

// MARK: - Courses store CRUD operation errors

enum CoursesStoreError: Equatable, ErrorType {
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
}

func==(lhs: CoursesStoreError, rhs: CoursesStoreError) -> Bool {
    switch (lhs, rhs) {
        case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
        case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
        case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
        case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
        default: return false
    }
}
