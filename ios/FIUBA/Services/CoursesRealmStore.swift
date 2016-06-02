//
//  CoursesRealmStore.swift
//  FIUBA
//

import RealmSwift

class CoursesRealmStore: CoursesStoreProtocol {

    func fetchCourses(completionHandler: CoursesStoreFetchCoursesCompletionHandler) {
        guard let realm = realm() else {
            completionHandler(result: CoursesStoreResult.Failure(error: CoursesStoreError.CannotFetch("No se pudo instanciar Realm")))
            return
        }

        let rlmCourses = realm.objects(CourseRLM)
        let courses: [Course] = rlmCourses.map { (rlmCourse) -> Course in
            return Course(id: rlmCourse.id,
                number: rlmCourse.number,
                teachers: rlmCourse.teachers,
                vacancies: rlmCourse.vacancies,
                enrolled: rlmCourse.enrolled)
        }
        completionHandler(result: CoursesStoreResult.Success(result: courses))
    }

    func fetchCourse(id: String, completionHandler: CoursesStoreFetchCourseCompletionHandler) {

    }

    func createCourse(courseToCreate: Course, completionHandler: CoursesStoreCreateCourseCompletionHandler) {

    }

    func createCourses(courses: [Course], completionHandler: CoursesStoreCreateCoursesCompletionHandler) {
        guard let realm = realm() else {
            completionHandler(result: CoursesStoreResult.Failure(error: CoursesStoreError.CannotCreate("No se pudo instanciar Realm")))
            return
        }

        let rlmCourses: [CourseRLM] = courses.map { (course) -> CourseRLM in
            let rlmCourse = CourseRLM()
            rlmCourse.id = course.id ?? ""
            rlmCourse.number = course.number ?? 0
            rlmCourse.teachers = course.teachers ?? ""
            rlmCourse.vacancies = course.vacancies ?? 0
            rlmCourse.enrolled = course.enrolled ?? false
            return rlmCourse
        }
        do {
            try realm.write {
                for course in rlmCourses {
                    realm.add(course)
                }
            }
        } catch {
            completionHandler(result: CoursesStoreResult.Failure(error: CoursesStoreError.CannotCreate("No se pudo escribir en Realm")))
            return
        }
        completionHandler(result: CoursesStoreResult.Success(result: ()))
    }

    func updateCourse(courseToUpdate: Course, completionHandler: CoursesStoreUpdateCourseCompletionHandler) {

    }

    func deleteCourse(id: String, completionHandler: CoursesStoreDeleteCourseCompletionHandler) {

    }

    // MARK: - Auxiliars

    private func realm() -> Realm? {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }

}
