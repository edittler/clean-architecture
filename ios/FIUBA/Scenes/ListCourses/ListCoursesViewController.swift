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
    var displayedCourses: [ListCourses.ViewModel.DisplayedCourse] = []
  
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
        displayedCourses = viewModel.displayedCourses
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath)

        let displayedCourse = displayedCourses[indexPath.row]
        cell.textLabel?.text = "Curso \(displayedCourse.number) - \(displayedCourse.teachers)"
        cell.detailTextLabel?.text = "Vacantes: \(displayedCourse.vacancies)"

        return cell
    }
    
}
