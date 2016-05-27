//
//  ListCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListCoursesViewControllerInput {
    func displayFetchedCourses(viewModel: ListCourses.ViewModel)
}

protocol ListCoursesViewControllerOutput {
    func fetchCourses(request: ListCourses.Request)
}

class ListCoursesViewController: UITableViewController,
    ListCoursesViewControllerInput {

    var output: ListCoursesViewControllerOutput!
    var router: ListCoursesRouter!
  
    // MARK: Object lifecycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ListCoursesConfigurator.sharedInstance.configure(self)
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCoursesOnLoad()
    }
  
    // MARK: Event handling
  
    func fetchCoursesOnLoad() {
        let request = ListCourses.Request()
        output.fetchCourses(request)
    }
  
    // MARK: Display logic
  
    func displayFetchedCourses(viewModel: ListCourses.ViewModel) {
        // NOTE: Display the result from the Presenter
    
        // nameTextField.text = viewModel.name
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    
}
