//
//  ListSubjectsWorker.swift
//  FIUBA
//

import Foundation

class ListSubjectsWorker: ListSubjectsWorkerProtocol {

    let subjectsWorker: SubjectsWorker = SubjectsWorker(subjectsStore: SubjectsRealmStore())

    // MARK: Business Logic

    func fetchSubjects(_ completionHandler: @escaping (_ subjects: [Subject]) -> Void) {
        subjectsWorker.fetchSubjects { (subjects) in
            completionHandler(subjects)
        }
    }

}
