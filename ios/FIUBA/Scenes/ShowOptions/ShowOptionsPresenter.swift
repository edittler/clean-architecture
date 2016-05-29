//
//  ShowOptionsPresenter.swift
//  FIUBA
//

import Foundation

class ShowOptionsPresenter: ShowOptionsInteractorOutput {
    weak var output: ShowOptionsViewInput!

    // MARK: Presentation logic

    func presentSomething(response: ShowOptions.Response) {
        // NOTE: Format the response from the Interactor and pass the result back to the View Controller

        let viewModel = ShowOptions.ViewModel()
        output.displaySomething(viewModel)
    }

}
