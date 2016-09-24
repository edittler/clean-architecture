//
//  ListCoursesViewController.swift
//  FIUBA
//

import UIKit

protocol ListCoursesViewProtocol: class {
    func displayFetchedCourses(_ viewModel: ListCourses.ViewModel)
    func displayEnrollCourseConfirmation(_ viewModel: ListCourses.SelectCourse.ViewModel)
    func displayEnrollCourseResult(_ viewModel: ListCourses.EnrollCourse.ViewModel)
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
  
    func displayFetchedCourses(_ viewModel: ListCourses.ViewModel) {
        displayedCourses = viewModel.displayedCourses
        tableView.reloadData()
    }

    func displayEnrollCourseConfirmation(_ viewModel: ListCourses.SelectCourse.ViewModel) {
        let message = "Curso \(viewModel.number)\n\(viewModel.teachers)\nVacantes:\(viewModel.vacancies)"
        let enrollCourseConfirmationAlert = UIAlertController(title: "Inscribirse",
                                                          message: message,
                                                          preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        enrollCourseConfirmationAlert.addAction(cancelAction)
        let enrollAction = UIAlertAction(title: "Inscribir", style: .default) { (alertAction) in
            self.output.enrollCourse(ListCourses.EnrollCourse.Request(id: viewModel.id))
        }
        enrollCourseConfirmationAlert.addAction(enrollAction)
        present(enrollCourseConfirmationAlert, animated: true, completion: nil)
    }

    func displayEnrollCourseResult(_ viewModel: ListCourses.EnrollCourse.ViewModel) {
        fetchCoursesOnLoad()
        let enrollCourseResultAlert = UIAlertController(title: viewModel.title,
                                                        message: viewModel.message,
                                                        preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
        enrollCourseResultAlert.addAction(cancelAction)
        present(enrollCourseResultAlert, animated: true, completion: nil)
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        let displayedCourse = displayedCourses[(indexPath as NSIndexPath).row]
        output.selectCourse(ListCourses.SelectCourse.Request(id: displayedCourse.id))
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return displayedCourses.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath)

        let displayedCourse = displayedCourses[(indexPath as NSIndexPath).row]
        if displayedCourse.enrolled {
            cell.backgroundColor = UIColor(red: 13/255, green: 148/255, blue: 252/255, alpha: 1)
            let label = UILabel(frame: CGRect.zero)
            label.text = "INSCRIPTO"
            label.backgroundColor = UIColor.red.withAlphaComponent(0.6)
            label.textColor = UIColor.white
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
