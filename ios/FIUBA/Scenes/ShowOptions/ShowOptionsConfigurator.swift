//
//  ShowOptionsConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ShowOptionsViewController {

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        router.passDataToNextScene(segue)
    }

}

class ShowOptionsConfigurator {

    // MARK: Object lifecycle

    class var sharedInstance: ShowOptionsConfigurator {

        struct Static {
            static var instance: ShowOptionsConfigurator?
            static var token: dispatch_once_t = 0
        }

        dispatch_once(&Static.token) {
            Static.instance = ShowOptionsConfigurator()
        }

        return Static.instance!
    }

    // MARK: Configuration

    func configure(viewController: ShowOptionsViewController) {
        let router = ShowOptionsRouter()
        router.viewController = viewController

        let presenter = ShowOptionsPresenter()
        presenter.output = viewController

        let interactor = ShowOptionsInteractor()
        interactor.output = presenter

        viewController.output = interactor
        viewController.router = router
    }

}
