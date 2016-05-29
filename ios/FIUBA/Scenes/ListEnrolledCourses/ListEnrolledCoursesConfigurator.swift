//
//  ListEnrolledCoursesConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListEnrolledCoursesViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }

}

class ListEnrolledCoursesConfigurator {

    // MARK: Object lifecycle
  
    class var sharedInstance: ListEnrolledCoursesConfigurator {
        struct Static {
            static var instance: ListEnrolledCoursesConfigurator?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = ListEnrolledCoursesConfigurator()
        }

        return Static.instance!
    }

    // MARK: Configuration

    func configure(viewController: ListEnrolledCoursesViewController) {
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
