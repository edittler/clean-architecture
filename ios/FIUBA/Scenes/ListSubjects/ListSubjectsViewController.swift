//
//  ListSubjectsViewController.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsViewProtocol: class {
    func displayFetchedSubjects(viewModel: ListSubjects.ViewModel)
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
  
    func displayFetchedSubjects(viewModel: ListSubjects.ViewModel) {
        displayedSubjects = viewModel.displayedSubjects
        tableView.reloadData()
    }

    // MARK: - UITableViewDelegate

    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {
        router.navigateToListCourses()
    }

    // MARK: - UITableViewDataSource

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedSubjects.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("subjectCell",
                                                               forIndexPath: indexPath)

        let displayedSubject = displayedSubjects[indexPath.row]
        cell.textLabel?.text = "\(displayedSubject.code) - \(displayedSubject.name)"

        return cell
    }

}
