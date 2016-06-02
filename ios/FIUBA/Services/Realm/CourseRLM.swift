//
//  CourseRLM.swift
//  FIUBA
//

import Foundation
import RealmSwift

class CourseRLM: Object {
    dynamic var id: String = ""
    dynamic var number: Int = 0
    dynamic var teachers: String = ""
    dynamic var vacancies: Int = 0
    dynamic var enrolled: Bool = false
}
