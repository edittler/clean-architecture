//
//  DegreeProgramsWorker.swift
//  FIUBA
//

import Foundation

class DegreeProgramsWorker {

    // MARK: Business Logic

    func fetchDegreePrograms(completionHandler: (degreePrograms: [DegreeProgram]) -> Void) {
        var degreePrograms: [DegreeProgram] = []
        degreePrograms.append(DegreeProgram(id: "ing-informatica",
            collegeDegree: "Ingeniería en Informática"))
        completionHandler(degreePrograms: degreePrograms)
    }

}
