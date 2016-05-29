//
//  ListEnrolledCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListEnrolledCoursesViewInput: class {
  func displaySomething(viewModel: ListEnrolledCourses.ViewModel)
}

class ListEnrolledCoursesViewController: UITableViewController,
    ListEnrolledCoursesViewInput {

    var output: ListEnrolledCoursesInteractorInput!
    var router: ListEnrolledCoursesRouter!
  
    // MARK: Object lifecycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ListEnrolledCoursesConfigurator.sharedInstance.configure(self)
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomethingOnLoad()
    }
  
    // MARK: Event handling
  
    func doSomethingOnLoad() {
        // NOTE: Ask the Interactor to do some work

        let request = ListEnrolledCourses.Request()
        output.doSomething(request)
    }
  
    // MARK: Display logic

    func displaySomething(viewModel: ListEnrolledCourses.ViewModel) {
        // NOTE: Display the result from the Presenter

        // nameTextField.text = viewModel.name
    }

    // MARK: - UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enrolledCourseCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
}
