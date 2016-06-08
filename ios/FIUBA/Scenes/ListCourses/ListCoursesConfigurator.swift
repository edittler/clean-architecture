//
//  ListCoursesConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListCoursesViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }

}

class ListCoursesConfigurator {

    // MARK: Object lifecycle
  
    class var sharedInstance: ListCoursesConfigurator {
        struct Static {
            static var instance: ListCoursesConfigurator?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = ListCoursesConfigurator()
        }

        return Static.instance!
    }
  
    // MARK: Configuration
  
    func configure(viewController: ListCoursesViewController) {
        let router = ListCoursesRouter()
        router.viewController = viewController
    
        let presenter = ListCoursesPresenter()
        presenter.output = viewController
    
        let interactor = ListCoursesInteractor()
        interactor.output = presenter
        interactor.worker = ListCoursesWorker()
    
        viewController.output = interactor
        viewController.router = router
    }

}
