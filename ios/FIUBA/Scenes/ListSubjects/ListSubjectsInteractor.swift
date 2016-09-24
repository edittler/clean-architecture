//
//  ListSubjectsInteractor.swift
//  FIUBA
//

import Foundation

protocol ListSubjectsInteractorInput {
    func fetchSubjects(_ request: ListSubjects.Request)
    var subjects: [Subject]? { get }
}

protocol ListSubjectsInteractorOutput {
    func presentFetchedSubjects(_ response: ListSubjects.Response)
}

protocol ListSubjectsWorkerProtocol {
    func fetchSubjects(_ completionHandler: @escaping (_ subjects: [Subject]) -> Void)
}

class ListSubjectsInteractor: ListSubjectsInteractorInput {
    var output: ListSubjectsInteractorOutput!
    var worker: ListSubjectsWorkerProtocol! = ListSubjectsWorker()

    var subjects: [Subject]?
  
    // MARK: Business logic
  
    func fetchSubjects(_ request: ListSubjects.Request) {
        worker.fetchSubjects { (subjects) in
            self.subjects = subjects
            let response = ListSubjects.Response(subjects: subjects)
            self.output.presentFetchedSubjects(response)
        }
    }

}
