//
//  ListCoursesConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListCoursesViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }

}

class ListCoursesConfigurator {

    // MARK: Object lifecycle
  
    static let sharedInstance: ListCoursesConfigurator = {
        let instance = ListCoursesConfigurator()
        return instance
    }()
  
    // MARK: Configuration
  
    func configure(_ viewController: ListCoursesViewController) {
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
