//
//  ListDegreeProgramsPresenter.swift
//  FIUBA
//

import UIKit

protocol ListDegreeProgramsPresenterInput {
    func presentFetchedDegreePrograms(response: ListDegreePrograms.Response)
}

protocol ListDegreeProgramsPresenterOutput: class {
    func displayFetchedDegreePrograms(viewModel: ListDegreePrograms.ViewModel)
}

class ListDegreeProgramsPresenter: ListDegreeProgramsPresenterInput {
    weak var output: ListDegreeProgramsPresenterOutput!

    // MARK: Presentation logic

    func presentFetchedDegreePrograms(response: ListDegreePrograms.Response) {
        var displayedDegreePrograms: [ListDegreePrograms.ViewModel.DisplayedDegreeProgram] = []
            for degreeProgram in response.degreePrograms {
                let displayedDegreeProgram = ListDegreePrograms.ViewModel.DisplayedDegreeProgram(
                    id: degreeProgram.id ?? "", collegeDegree: degreeProgram.collegeDegree ?? "")
                displayedDegreePrograms.append(displayedDegreeProgram)
            }

        let viewModel = ListDegreePrograms.ViewModel(
            displayedDegreePrograms: displayedDegreePrograms)
        output.displayFetchedDegreePrograms(viewModel)
    }

}
