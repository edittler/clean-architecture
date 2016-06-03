//
//  CoursesJsonStore.swift
//  FIUBA
//

import Foundation

typealias Payload = [String: AnyObject]

class CoursesJsonStore: CoursesStoreProtocol {

    func fetchCourses(completionHandler: CoursesStoreFetchCoursesCompletionHandler) {
        DataManager.loadDataFromJsonFile("courses", success: { (data) in
            var json: Payload!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions()) as? Payload
                guard let coursesArray = json["courses"] as? [Payload] else {
                    completionHandler(result: CoursesStoreResult.Failure(error: CoursesStoreError.CannotFetch("Cannot fetch courses")))
                    return
                }
                let courses = coursesArray.map({ (dict) -> Course in
                    let course = Course(id: dict["id"] as? String,
                        subjectId: dict["subjectId"] as? String,
                        number: dict["number"] as? Int,
                        teachers: dict["teachers"] as? String,
                        vacancies: dict["vacancy"] as? Int,
                        enrolled: false)
                    return course
                })
                completionHandler(result: CoursesStoreResult.Success(result: courses))
            } catch {
                completionHandler(result: CoursesStoreResult.Failure(error: CoursesStoreError.CannotFetch("Cannot fetch courses")))
            }

        })
    }

    func fetchCoursesBySubject(subject: Subject, completionHandler: CoursesStoreFetchCoursesCompletionHandler) {
        
    }

    func fetchCourse(id: String, completionHandler: CoursesStoreFetchCourseCompletionHandler) {

    }

    func createCourse(courseToCreate: Course, completionHandler: CoursesStoreCreateCourseCompletionHandler) {

    }

    func createCourses(coursesToCreate: [Course], completionHandler: CoursesStoreCreateCoursesCompletionHandler) {
        
    }

    func updateCourse(courseToUpdate: Course, completionHandler: CoursesStoreUpdateCourseCompletionHandler) {

    }

    func deleteCourse(id: String, completionHandler: CoursesStoreDeleteCourseCompletionHandler) {
        
    }
    
}
