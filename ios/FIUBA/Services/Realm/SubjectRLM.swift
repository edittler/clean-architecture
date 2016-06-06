//
//  SubjectRLM.swift
//  FIUBA
//

import RealmSwift

class SubjectRLM: Object {
    dynamic var id: String = ""
    dynamic var code: String = ""
    dynamic var name: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }

}
