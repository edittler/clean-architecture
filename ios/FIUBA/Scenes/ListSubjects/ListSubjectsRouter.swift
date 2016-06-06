//
//  ListSubjectsRouter.swift
//  FIUBA
//

import UIKit

protocol ListSubjectsRouterProtocol {
    func navigateToListCourses()
}

class ListSubjectsRouter: ListSubjectsRouterProtocol {

    private static let ShowListCoursesSegueId = "ShowListCoursesScene"

    weak var viewController: ListSubjectsViewController!
  
    // MARK: Navigation
  
    func navigateToListCourses() {
        // NOTE: Teach the router how to navigate to another scene. Some examples follow:
    
        // 1. Trigger a storyboard segue
        viewController.performSegueWithIdentifier(ListSubjectsRouter.ShowListCoursesSegueId, sender: nil)
    
        // 2. Present another view controller programmatically
        // viewController.presentViewController(someWhereViewController, animated: true, completion: nil)
    
        // 3. Ask the navigation controller to push another view controller onto the stack
        // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    
        // 4. Present a view controller from a different storyboard
        // let storyboard = UIStoryboard(name: "OtherThanMain", bundle: nil)
        // let someWhereViewController = storyboard.instantiateInitialViewController() as! SomeWhereViewController
        // viewController.navigationController?.pushViewController(someWhereViewController, animated: true)
    }
  
    // MARK: Communication
  
    func passDataToNextScene(segue: UIStoryboardSegue) {
        // NOTE: Teach the router which scenes it can communicate with
    
        if segue.identifier == ListSubjectsRouter.ShowListCoursesSegueId {
            passDataToListCoursesScene(segue)
        }
    }
  
    func passDataToListCoursesScene(segue: UIStoryboardSegue) {
        if let selectedIndexPath = viewController.tableView.indexPathForSelectedRow {
            if let selectedSubject = viewController.output.subjects?[selectedIndexPath.row] {
                // swiftlint:disable:next force_cast
                let listCoursesViewController = segue.destinationViewController as! ListCoursesViewController
                listCoursesViewController.output.subject = selectedSubject
            }
        }
    }

}
