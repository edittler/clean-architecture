//
//  ListEnrolledCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListEnrolledCoursesViewInput: class {
    func displayFetchedEnrolledCourses(_ viewModel: ListEnrolledCourses.ViewModel)
    func displayUnenrollCourseResult(_ viewModel: ListEnrolledCourses.UnenrollCourse.ViewModel)
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

    func displayFetchedEnrolledCourses(_ viewModel: ListEnrolledCourses.ViewModel) {
        displayedCourses = viewModel.displayedCourses
        tableView.reloadData()
    }

    func displayUnenrollCourseResult(_ viewModel: ListEnrolledCourses.UnenrollCourse.ViewModel) {
        fetchEnrolledCoursesOnLoad()
        let unenrollCourseResultAlert = UIAlertController(title: viewModel.title,
                                                          message: viewModel.message,
                                                          preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
        unenrollCourseResultAlert.addAction(cancelAction)
        present(unenrollCourseResultAlert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "enrolledCourseCell", for: indexPath)

        let displayedCourse = displayedCourses[(indexPath as NSIndexPath).row]

        cell.textLabel?.text = "Curso \(displayedCourse.number) - \(displayedCourse.teachers)"
        cell.detailTextLabel?.text = "Vacantes: \(displayedCourse.vacancies)"

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let displayedCourse = displayedCourses[(indexPath as NSIndexPath).row]

        let message = "¿Está seguro que desea desuscribirse del curso?"
        let enrollCourseConfirmationAlert = UIAlertController(title: "Desuscribirse",
                                                              message: message,
                                                              preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        enrollCourseConfirmationAlert.addAction(cancelAction)
        let enrollAction = UIAlertAction(title: "Desuscribir", style: .default) { (alertAction) in
            self.output.unenrollCourse(ListEnrolledCourses.UnenrollCourse.Request(id: displayedCourse.id))
        }
        enrollCourseConfirmationAlert.addAction(enrollAction)
        present(enrollCourseConfirmationAlert, animated: true, completion: nil)

        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unrollAction = UITableViewRowAction(style: .destructive, title: "DESUSCRIBIR") { (action, indexPath) -> Void in
            let alert = UIAlertController(title: "Desuscribir", message: "¿Está seguro que desea desuscribirse del curso?", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in

            })
            let unrollAction = UIAlertAction(title: "Desuscribir", style: .destructive, handler: { (alertAction) in

            })

            alert.addAction(cancelAction)
            alert.addAction(unrollAction)

            self.setEditing(false, animated: true)
            self.present(alert, animated: true, completion: nil)
        }
        return [unrollAction]
    }
    
}
