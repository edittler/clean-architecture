//
//  ListSubjectsViewController.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsViewProtocol: class {
    func displayFetchedSubjects(_ viewModel: ListSubjects.ViewModel)
}

class ListSubjectsViewController: UITableViewController,
    ListSubjectsViewProtocol {

    var output: ListSubjectsInteractorInput!
    var router: ListSubjectsRouter!
    var displayedSubjects: [ListSubjects.ViewModel.DisplayedSubject] = []
  
    // MARK: Object lifecycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ListSubjectsConfigurator.sharedInstance.configure(self)
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSubjectsOnLoad()
    }
  
    // MARK: Event handling
  
    func fetchSubjectsOnLoad() {
        let request = ListSubjects.Request()
        output.fetchSubjects(request)
    }
  
    // MARK: Display logic
  
    func displayFetchedSubjects(_ viewModel: ListSubjects.ViewModel) {
        displayedSubjects = viewModel.displayedSubjects
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        router.navigateToListCourses()
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSubjects.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell",
                                                               for: indexPath)

        let displayedSubject = displayedSubjects[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = "\(displayedSubject.code) - \(displayedSubject.name)"

        return cell
    }

}
