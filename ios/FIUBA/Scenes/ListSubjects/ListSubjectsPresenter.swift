//
//  ListSubjectsPresenter.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsPresenterInput {
    func presentFetchedSubjets(response: ListSubjects.Response)
}

protocol ListSubjectsPresenterOutput: class {
    func displaySomething(viewModel: ListSubjects.ViewModel)
}

class ListSubjectsPresenter: ListSubjectsPresenterInput {
    weak var output: ListSubjectsPresenterOutput!
  
    // MARK: Presentation logic
  
    func presentFetchedSubjets(response: ListSubjects.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller
    
        let viewModel = ListSubjects.ViewModel()
        output.displaySomething(viewModel)
    }

}
