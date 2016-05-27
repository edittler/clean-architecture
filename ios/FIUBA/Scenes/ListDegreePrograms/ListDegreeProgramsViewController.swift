//
//  ListDegreeProgramsViewController.swift
//  FIUBA
//

import UIKit

protocol ListDegreeProgramsViewControllerInput {
    func displayFetchedDegreePrograms(viewModel: ListDegreePrograms.ViewModel)
}

protocol ListDegreeProgramsViewControllerOutput {
    func fetchDegreePrograms(request: ListDegreePrograms.Request)
}

class ListDegreeProgramsViewController: UITableViewController,
    ListDegreeProgramsViewControllerInput {

    var output: ListDegreeProgramsViewControllerOutput!
    var router: ListDegreeProgramsRouter!
    var displayedDegreePrograms: [ListDegreePrograms.ViewModel.DisplayedDegreeProgram] = []

    // MARK: Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        ListDegreeProgramsConfigurator.sharedInstance.configure(self)
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDegreeProgramsOnLoad()
    }

    // MARK: Event handling

    func fetchDegreeProgramsOnLoad() {
        let request = ListDegreePrograms.Request()
        output.fetchDegreePrograms(request)
    }

    // MARK: Display logic

    func displayFetchedDegreePrograms(viewModel: ListDegreePrograms.ViewModel) {
        displayedDegreePrograms = viewModel.displayedDegreePrograms
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

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedDegreePrograms.count
    }

    override func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("degreeProgramCell",
                                                               forIndexPath: indexPath)

        let displayedDegreeProgram = displayedDegreePrograms[indexPath.row]
        cell.textLabel?.text = displayedDegreeProgram.collegeDegree

        return cell
    }

}
