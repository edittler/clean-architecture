//
//  ListSubjectsInteractor.swift
//  FIUBA
//

import Foundation

protocol ListSubjectsInteractorInput {
    func fetchSubjects(request: ListSubjects.Request)
}

protocol ListSubjectsInteractorOutput {
    func presentFetchedSubjects(response: ListSubjects.Response)
}

class ListSubjectsInteractor: ListSubjectsInteractorInput {
    var output: ListSubjectsInteractorOutput!
    var worker: ListSubjectsWorker!

    var subjectsWorker = SubjectsWorker(subjectsStore: SubjectsJsonStore())
  
    // MARK: Business logic
  
    func fetchSubjects(request: ListSubjects.Request) {
        subjectsWorker.fetchSubjects { (subjects) in
            let response = ListSubjects.Response(subjects: subjects)
            self.output.presentFetchedSubjects(response)
        }
    }

}
