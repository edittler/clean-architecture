//
//  SubjectsWorker.swift
//  FIUBA
//

import Foundation

class SubjectsWorker {

    // MARK: Business Logic

    func fetchSubjects(completionHandler: (subjects: [Subject]) -> Void) {
        var subjects: [Subject] = []
        //subjects.append(Subject(id: "", code: "61.09", name: "Probabilidad y Estadística B"))
        subjects.append(Subject(id: "", code: "75.09", name: "Análisis de la Información"))
        completionHandler(subjects: subjects)
    }

}
