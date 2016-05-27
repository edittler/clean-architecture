//
//  ListSubjectsViewController.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsViewControllerInput {
    func displayFetchedSubjects(viewModel: ListSubjects.ViewModel)
}

protocol ListSubjectsViewControllerOutput {
    func fetchSubjects(request: ListSubjects.Request)
}

class ListSubjectsViewController: UITableViewController,
    ListSubjectsViewControllerInput {

    var output: ListSubjectsViewControllerOutput!
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
