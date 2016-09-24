//
//  ShowOptionsViewController.swift
//  FIUBA
//

import UIKit

protocol ShowOptionsViewInput: class {
    func displaySomething(_ viewModel: ShowOptions.ViewModel)
}

class ShowOptionsViewController: UIViewController, ShowOptionsViewInput {

    var output: ShowOptionsInteractorInput!
    var router: ShowOptionsRouter!
  
    // MARK: Object lifecycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ShowOptionsConfigurator.sharedInstance.configure(self)
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomethingOnLoad()
    }

    // MARK: Event handling

    func doSomethingOnLoad() {
        // NOTE: Ask the Interactor to do some work

        let request = ShowOptions.Request()
        output.doSomething(request)
    }
  
    // MARK: Display logic

    func displaySomething(_ viewModel: ShowOptions.ViewModel) {
        // NOTE: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }

}
