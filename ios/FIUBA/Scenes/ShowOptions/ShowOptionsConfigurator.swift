//
//  ShowOptionsConfigurator.swift
//  FIUBA
//

import UIKit

// MARK: Connect View, Interactor, and Presenter

extension ShowOptionsViewController {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue)
    }

}

class ShowOptionsConfigurator {

    // MARK: Object lifecycle

    static let sharedInstance: ShowOptionsConfigurator = {
        let instance = ShowOptionsConfigurator()
        return instance
    }()

    // MARK: Configuration

    func configure(_ viewController: ShowOptionsViewController) {
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
