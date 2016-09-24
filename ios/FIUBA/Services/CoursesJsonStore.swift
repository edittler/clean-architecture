//
//  CoursesJsonStore.swift
//  FIUBA
//

import Foundation

typealias Payload = [String: AnyObject]

class CoursesJsonStore: CoursesStoreProtocol {

    func fetchCourses(_ completionHandler: @escaping CoursesStoreFetchCoursesCompletionHandler) {
        DataManager.loadDataFromJsonFile("courses", success: { (data) in
            var json: Payload!
            do {
                json = try JSONSerialization.jsonObject(with: data,
                    options: JSONSerialization.ReadingOptions()) as? Payload
                guard let coursesArray = json["courses"] as? [Payload] else {
                    completionHandler(CoursesStoreResult.failure(error: CoursesStoreError.cannotFetch("Cannot fetch courses")))
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
                completionHandler(CoursesStoreResult.success(result: courses))
            } catch {
                completionHandler(CoursesStoreResult.failure(error: CoursesStoreError.cannotFetch("Cannot fetch courses")))
            }

        })
    }

    func fetchCoursesBySubject(_ subject: Subject, completionHandler: CoursesStoreFetchCoursesCompletionHandler) {
        
    }

    func fetchEnrolledCourses(_ completionHandler: CoursesStoreFetchCoursesCompletionHandler) {
        
    }

    func fetchCourse(_ id: String, completionHandler: CoursesStoreFetchCourseCompletionHandler) {

    }

    func createCourse(_ courseToCreate: Course, completionHandler: CoursesStoreCreateCourseCompletionHandler) {

    }

    func createCourses(_ coursesToCreate: [Course], completionHandler: CoursesStoreCreateCoursesCompletionHandler) {
        
    }

    func updateCourse(_ courseToUpdate: Course, completionHandler: CoursesStoreUpdateCourseCompletionHandler) {

    }

    func deleteCourse(_ id: String, completionHandler: CoursesStoreDeleteCourseCompletionHandler) {
        
    }
    
}
