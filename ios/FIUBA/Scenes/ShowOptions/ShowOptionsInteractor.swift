//
//  ShowOptionsInteractor.swift
//  FIUBA
//

import Foundation

protocol ShowOptionsInteractorInput {
    func doSomething(request: ShowOptions.Request)
}

protocol ShowOptionsInteractorOutput {
    func presentSomething(response: ShowOptions.Response)
}

class ShowOptionsInteractor: ShowOptionsInteractorInput {
    var output: ShowOptionsInteractorOutput!
    var worker: ShowOptionsWorker!
  
    // MARK: Business logic
  
    func doSomething(request: ShowOptions.Request) {
        // NOTE: Create some Worker to do the work
    
        worker = ShowOptionsWorker()
        worker.doSomeWork()
    
        // NOTE: Pass the result to the Presenter
    
        let response = ShowOptions.Response()
        output.presentSomething(response)
    }

}
