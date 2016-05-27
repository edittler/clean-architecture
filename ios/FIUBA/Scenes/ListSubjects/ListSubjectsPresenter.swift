//
//  ListSubjectsPresenter.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsPresenterInput {
    func presentFetchedSubjects(response: ListSubjects.Response)
}

protocol ListSubjectsPresenterOutput: class {
    func displayFetchedSubjects(viewModel: ListSubjects.ViewModel)
}

class ListSubjectsPresenter: ListSubjectsPresenterInput {
    weak var output: ListSubjectsPresenterOutput!
  
    // MARK: Presentation logic
  
    func presentFetchedSubjects(response: ListSubjects.Response) {
        var displayedSubjects: [ListSubjects.ViewModel.DisplayedSubject] = []

        for subject in response.subjects {
            let displayedSubject = ListSubjects.ViewModel.DisplayedSubject(
                id: subject.id ?? "", code: subject.code ?? "", name: subject.name ?? "")
            displayedSubjects.append(displayedSubject)
        }
        output.displayFetchedSubjects(ListSubjects.ViewModel(displayedSubjects: displayedSubjects))
    }

}
