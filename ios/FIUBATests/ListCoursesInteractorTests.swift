//
//  ListCoursesInteractorTests.swift
//  FIUBA
//
//  Created by Ezequiel Pérez Dittler on 7/6/16.
//  Copyright © 2016 FIUBA. All rights reserved.
//

import XCTest
@testable import FIUBA

class ListCoursesWorkerMock: ListCoursesWorkerProtocol {
    var enrollCount: Int = 0

    func fetchCoursesBySubject(subject: Subject, completionHandler: (courses: [Course]) -> Void) {

    }

    func fetchEnrolledCourses(completionHandler: (courses: [Course]) -> Void) {
        var courses: [Course] = []
        for _ in 0..<enrollCount {
            courses.append(Course())
        }
        completionHandler(courses: courses)
    }

    func enrollCourse(id: String) {
        enrollCount += 1
    }

}

class ListCoursesPresenterMock: ListCoursesInteractorOutput {

    var enrollCourseResponse: ListCourses.EnrollCourse.Response?

    func presentFetchedCourses(response: ListCourses.Response) {

    }

    func presentEnrollCourseConfirmation(response: ListCourses.SelectCourse.Response) {

    }

    func presentEnrollCourseResult(response: ListCourses.EnrollCourse.Response) {
        enrollCourseResponse = response
    }

}

class ListCoursesInteractorTests: XCTestCase {

    var listCoursesInteractor: ListCoursesInteractor!
    var listCoursesPresenter: ListCoursesPresenterMock!
    
    override func setUp() {
        super.setUp()
        // Put setup code here.
        // This method is called before the invocation of each test method in the class.
        listCoursesPresenter = ListCoursesPresenterMock()
        listCoursesInteractor = ListCoursesInteractor()
        listCoursesInteractor.output = listCoursesPresenter
        listCoursesInteractor.worker = ListCoursesWorkerMock()
    }
    
    override func tearDown() {
        // Put teardown code here.
        // This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEnrollOneCourse() {
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        XCTAssertTrue(listCoursesPresenter.enrollCourseResponse!.enrollSuccess)
    }

    func testEnrollTwoCourses() {
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        XCTAssertTrue(listCoursesPresenter.enrollCourseResponse!.enrollSuccess)
    }

    func testEnrollThreeCourses() {
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        XCTAssertTrue(listCoursesPresenter.enrollCourseResponse!.enrollSuccess)
    }

    func testEnrollFourCourses() {
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        listCoursesInteractor.enrollCourse(ListCourses.EnrollCourse.Request(id: ""))
        XCTAssertFalse(listCoursesPresenter.enrollCourseResponse!.enrollSuccess)
    }

}
