//
//  ListDegreeProgramsConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListDegreeProgramsViewController: ListDegreeProgramsPresenterOutput {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }

}

extension ListDegreeProgramsInteractor: ListDegreeProgramsViewControllerOutput {
}

extension ListDegreeProgramsPresenter: ListDegreeProgramsInteractorOutput {
}

class ListDegreeProgramsConfigurator {

    // MARK: Object lifecycle

    class var sharedInstance: ListDegreeProgramsConfigurator {
        struct Static {
            static var instance: ListDegreeProgramsConfigurator?
            static var token: dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.instance = ListDegreeProgramsConfigurator()
        }

        return Static.instance!
    }

    // MARK: Configuration

    func configure(viewController: ListDegreeProgramsViewController) {
        let router = ListDegreeProgramsRouter()
        router.viewController = viewController

        let presenter = ListDegreeProgramsPresenter()
        presenter.output = viewController

        let interactor = ListDegreeProgramsInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
  }

}
