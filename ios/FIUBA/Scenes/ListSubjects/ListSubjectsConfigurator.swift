//
//  ListSubjectsConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListSubjectsViewController: ListSubjectsPresenterOutput {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }

}

extension ListSubjectsInteractor: ListSubjectsViewControllerOutput {
}

extension ListSubjectsPresenter: ListSubjectsInteractorOutput {
}

class ListSubjectsConfigurator {

    // MARK: Object lifecycle
  
    class var sharedInstance: ListSubjectsConfigurator {
        struct Static {
            static var instance: ListSubjectsConfigurator?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = ListSubjectsConfigurator()
        }
    
        return Static.instance!
    }
  
    // MARK: Configuration
  
    func configure(viewController: ListSubjectsViewController) {
        let router = ListSubjectsRouter()
        router.viewController = viewController
    
        let presenter = ListSubjectsPresenter()
        presenter.output = viewController
    
        let interactor = ListSubjectsInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
        viewController.router = router
    }

}
