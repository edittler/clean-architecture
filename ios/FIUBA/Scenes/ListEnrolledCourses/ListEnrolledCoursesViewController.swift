//
//  ListEnrolledCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListEnrolledCoursesViewInput: class {
    func displayFetchedEnrolledCourses(viewModel: ListEnrolledCourses.ViewModel)
    func displayUnenrollCourseResult(viewModel: ListEnrolledCourses.UnenrollCourse.ViewModel)
}

class ListEnrolledCoursesViewController: UITableViewController,
    ListEnrolledCoursesViewInput {

    var output: ListEnrolledCoursesInteractorInput!
    var router: ListEnrolledCoursesRouter!

    var displayedCourses: [ListEnrolledCourses.ViewModel.DisplayedCourse] = []
  
    // MARK: Object lifecycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ListEnrolledCoursesConfigurator.sharedInstance.configure(self)
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.allowsMultipleSelectionDuringEditing = false
        fetchEnrolledCoursesOnLoad()
    }
  
    // MARK: Event handling
  
    func fetchEnrolledCoursesOnLoad() {
        let request = ListEnrolledCourses.Request()
        output.fetchEnrolledCourses(request)
    }
  
    // MARK: Display logic

    func displayFetchedEnrolledCourses(viewModel: ListEnrolledCourses.ViewModel) {
        displayedCourses = viewModel.displayedCourses
        tableView.reloadData()
    }

    func displayUnenrollCourseResult(viewModel: ListEnrolledCourses.UnenrollCourse.ViewModel) {
        fetchEnrolledCoursesOnLoad()
        let unenrollCourseResultAlert = UIAlertController(title: viewModel.title,
                                                          message: viewModel.message,
                                                          preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: .Cancel, handler: nil)
        unenrollCourseResultAlert.addAction(cancelAction)
        presentViewController(unenrollCourseResultAlert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("enrolledCourseCell", forIndexPath: indexPath)

        let displayedCourse = displayedCourses[indexPath.row]

        cell.textLabel?.text = "Curso \(displayedCourse.number) - \(displayedCourse.teachers)"
        cell.detailTextLabel?.text = "Vacantes: \(displayedCourse.vacancies)"

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {

    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let displayedCourse = displayedCourses[indexPath.row]

        let message = "¿Está seguro que desea desuscribirse del curso?"
        let enrollCourseConfirmationAlert = UIAlertController(title: "Desuscribirse",
                                                              message: message,
                                                              preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel, handler: nil)
        enrollCourseConfirmationAlert.addAction(cancelAction)
        let enrollAction = UIAlertAction(title: "Desuscribir", style: .Default) { (alertAction) in
            self.output.unenrollCourse(ListEnrolledCourses.UnenrollCourse.Request(id: displayedCourse.id))
        }
        enrollCourseConfirmationAlert.addAction(enrollAction)
        presentViewController(enrollCourseConfirmationAlert, animated: true, completion: nil)

        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let unrollAction = UITableViewRowAction(style: .Destructive, title: "DESUSCRIBIR") { (action, indexPath) -> Void in
            let alert = UIAlertController(title: "Desuscribir", message: "¿Está seguro que desea desuscribirse del curso?", preferredStyle: .Alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: { (alertAction) in

            })
            let unrollAction = UIAlertAction(title: "Desuscribir", style: .Destructive, handler: { (alertAction) in

            })

            alert.addAction(cancelAction)
            alert.addAction(unrollAction)

            self.setEditing(false, animated: true)
            self.presentViewController(alert, animated: true, completion: nil)
        }
        return [unrollAction]
    }
    
}
