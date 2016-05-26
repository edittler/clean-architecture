//
//  ListDegreeProgramsModels.swift
//  FIUBA
//

import UIKit

struct ListDegreePrograms {

    struct Request {
    }

    struct Response {
        var degreePrograms: [DegreeProgram]
    }

    struct ViewModel {

        struct DisplayedDegreeProgram {
            var id: String
            var collegeDegree: String
        }

        var displayedDegreePrograms: [DisplayedDegreeProgram]
    }

}
