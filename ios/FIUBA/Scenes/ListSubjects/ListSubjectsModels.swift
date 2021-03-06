//
//  ListSubjectsModels.swift
//  FIUBA
//

import Foundation

struct ListSubjects {

    struct Request {
    }

    struct Response {
        var subjects: [Subject]
    }

    struct ViewModel {

        struct DisplayedSubject {
            var id: String
            var code: String
            var name: String
        }

        var displayedSubjects: [DisplayedSubject]
    }

}
