//
//  ListEnrolledCoursesConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListEnrolledCoursesViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }

}

class ListEnrolledCoursesConfigurator {

    // MARK: Object lifecycle
  
    class var sharedInstance: ListEnrolledCoursesConfigurator {
        let instance = ListEnrolledCoursesConfigurator()
        return instance
    }

    // MARK: Configuration

    func configure(_ viewController: ListEnrolledCoursesViewController) {
        let router = ListEnrolledCoursesRouter()
        router.viewController = viewController

        let presenter = ListEnrolledCoursesPresenter()
        presenter.output = viewController

        let interactor = ListEnrolledCoursesInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }

}
