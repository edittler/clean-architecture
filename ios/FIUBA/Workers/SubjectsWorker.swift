//
//  SubjectsWorker.swift
//  FIUBA
//

import Foundation

class SubjectsWorker {

    // MARK: Business Logic
  
    func doSomeWork() {
        // NOTE: Do the work
    }

    func fetchSubjects(completionHandler: (degreePrograms: [DegreeProgram]) -> Void) {
        var degreePrograms: [DegreeProgram] = []
        degreePrograms.append(DegreeProgram(id: "ing-informatica",
            collegeDegree: "Ingeniería en Informática"))
        completionHandler(degreePrograms: degreePrograms)
    }

}
