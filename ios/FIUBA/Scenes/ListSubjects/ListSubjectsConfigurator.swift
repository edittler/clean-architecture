//
//  ListSubjectsConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ListSubjectsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }

}

class ListSubjectsConfigurator {

    // MARK: Object lifecycle
  
    static let sharedInstance: ListSubjectsConfigurator = {
        let instance = ListSubjectsConfigurator()
        return instance
    }()
  
    // MARK: Configuration
  
    func configure(_ viewController: ListSubjectsViewController) {
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
