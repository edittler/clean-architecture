//
//  ListCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListCoursesViewControllerInput {
    func displayFetchedCourses(viewModel: ListCourses.ViewModel)
    func displayEnrollCourseConfirmation(viewModel: ListCourses.SelectCourse.ViewModel)
}

protocol ListCoursesViewControllerOutput {
    func fetchCourses(request: ListCourses.Request)
    func selectCourse(request: ListCourses.SelectCourse.Request)
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

    func displayEnrollCourseConfirmation(viewModel: ListCourses.SelectCourse.ViewModel) {
        let message = "Curso \(viewModel.number)\n\(viewModel.teachers)\nVacantes:\(viewModel.vacancies)"
        let enrollCourseConfirmationAlert = UIAlertController(title: "Inscribirse",
                                                          message: message,
                                                          preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        enrollCourseConfirmationAlert.addAction(cancelAction)
        let enrollAction = UIAlertAction(title: "Inscribir", style: .Default) { (alertAction) in
            NSLog("Enroll!!")
        }
        enrollCourseConfirmationAlert.addAction(enrollAction)
        presentViewController(enrollCourseConfirmationAlert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let displayedCourse = displayedCourses[indexPath.row]
        output.selectCourse(ListCourses.SelectCourse.Request(id: displayedCourse.id))
        
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
