//
//  ListCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListCoursesViewProtocol: class {
    func displayFetchedCourses(viewModel: ListCourses.ViewModel)
    func displayEnrollCourseConfirmation(viewModel: ListCourses.SelectCourse.ViewModel)
    func displayEnrollCourseResult(viewModel: ListCourses.EnrollCourse.ViewModel)
}

class ListCoursesViewController: UITableViewController,
    ListCoursesViewProtocol {

    // MARK: VIP Attributes
    var output: ListCoursesInteractorInput!
    var router: ListCoursesRouter!

    // MARK: Content Attributes
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
            self.output.enrollCourse(ListCourses.EnrollCourse.Request(id: viewModel.id))
        }
        enrollCourseConfirmationAlert.addAction(enrollAction)
        presentViewController(enrollCourseConfirmationAlert, animated: true, completion: nil)
    }

    func displayEnrollCourseResult(viewModel: ListCourses.EnrollCourse.ViewModel) {
        fetchCoursesOnLoad()
        let enrollCourseResultAlert = UIAlertController(title: viewModel.title,
                                                        message: viewModel.message,
                                                        preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: .Cancel, handler: nil)
        enrollCourseResultAlert.addAction(cancelAction)
        presentViewController(enrollCourseResultAlert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let displayedCourse = displayedCourses[indexPath.row]
        output.selectCourse(ListCourses.SelectCourse.Request(id: displayedCourse.id))
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // MARK: - UITableViewDataSource

    override func tableView(tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("courseCell", forIndexPath: indexPath)

        let displayedCourse = displayedCourses[indexPath.row]
        if displayedCourse.enrolled {
            cell.backgroundColor = UIColor(red: 13/255, green: 148/255, blue: 252/255, alpha: 1)
            let label = UILabel(frame: CGRect.zero)
            label.text = "INSCRIPTO"
            label.backgroundColor = UIColor.redColor().colorWithAlphaComponent(0.6)
            label.textColor = UIColor.whiteColor()
            label.sizeToFit()
            label.clipsToBounds = true
            label.layer.cornerRadius = 5
            cell.accessoryView = label
        }

        cell.textLabel?.text = "Curso \(displayedCourse.number) - \(displayedCourse.teachers)"
        cell.detailTextLabel?.text = "Vacantes: \(displayedCourse.vacancies)"

        return cell
    }
    
}
