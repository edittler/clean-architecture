//
//  ListSubjectsInteractor.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsInteractorInput {
    func fetchSubjects(request: ListSubjects.Request)
}

protocol ListSubjectsInteractorOutput {
    func presentFetchedSubjets(response: ListSubjects.Response)
}

class ListSubjectsInteractor: ListSubjectsInteractorInput {
    var output: ListSubjectsInteractorOutput!
    var worker: ListSubjectsWorker!
  
    // MARK: Business logic
  
    func fetchSubjects(request: ListSubjects.Request) {
        // NOTE: Create some Worker to do the work
    
        worker = ListSubjectsWorker()
        worker.doSomeWork()
    
        // NOTE: Pass the result to the Presenter
    
        let response = ListSubjects.Response()
        output.presentFetchedSubjets(response)
    }

}
