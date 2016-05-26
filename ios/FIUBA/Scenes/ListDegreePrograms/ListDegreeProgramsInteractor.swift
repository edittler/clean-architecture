//
//  ListDegreeProgramsInteractor.swift
//  FIUBA
//

import UIKit

protocol ListDegreeProgramsInteractorInput {
    func fetchDegreePrograms(request: ListDegreePrograms.Request)
}

protocol ListDegreeProgramsInteractorOutput {
    func presentFetchedDegreePrograms(response: ListDegreePrograms.Response)
}

class ListDegreeProgramsInteractor: ListDegreeProgramsInteractorInput {

    var output: ListDegreeProgramsInteractorOutput!
    var worker: ListDegreeProgramsWorker!

    var degreeProgramsWorker = DegreeProgramsWorker()

    // MARK: Business logic

    func fetchDegreePrograms(request: ListDegreePrograms.Request) {
        // NOTE: Create some Worker to do the work

        worker = ListDegreeProgramsWorker()
        worker.doSomeWork()

        // NOTE: Pass the result to the Presenter
        degreeProgramsWorker.fetchDegreePrograms { (degreePrograms) in
            let response = ListDegreePrograms.Response(degreePrograms: degreePrograms)
            self.output.presentFetchedDegreePrograms(response)
        }
    }

}
