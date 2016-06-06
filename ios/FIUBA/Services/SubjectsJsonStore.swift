//
//  SubjectsJsonStore.swift
//  FIUBA
//

import Foundation

class SubjectsJsonStore: SubjectsStoreProtocol {

    // MARK: CRUD operations - Generic enum result type

    func fetchSubjects(completionHandler: SubjectsStoreFetchSubjectsCompletionHandler) {
        DataManager.loadDataFromJsonFile("subjects", success: { (data) in
            var json: Payload!
            do {
                json = try NSJSONSerialization.JSONObjectWithData(data,
                    options: NSJSONReadingOptions()) as? Payload
                guard let subjectsArray = json["subjects"] as? [Payload] else {
                    completionHandler(result: SubjectsStoreResult.Failure(error: SubjectsStoreError.CannotFetch("Cannot fetch subjects")))
                    return
                }
                let subjects = subjectsArray.map({ (dict) -> Subject in
                    let subject = Subject(id: dict["id"] as? String,
                        code: dict["code"] as? String,
                        name: dict["name"] as? String)
                    return subject
                })
                completionHandler(result: SubjectsStoreResult.Success(result: subjects))
            } catch {
                completionHandler(result: SubjectsStoreResult.Failure(error: SubjectsStoreError.CannotFetch("Cannot fetch subjects")))
            }

        })
    }

    func fetchSubject(id: String, completionHandler: SubjectsStoreFetchSubjectCompletionHandler) {

    }

    func createSubject(subjectToCreate: Subject, completionHandler: SubjectsStoreCreateSubjectCompletionHandler) {

    }

    func createSubjects(subjectsToCreate: [Subject], completionHandler: SubjectsStoreCreateSubjectsCompletionHandler) {

    }

    func updateSubject(subjectToUpdate: Subject, completionHandler: SubjectsStoreUpdateSubjectCompletionHandler) {

    }

    func deleteSubject(id: String, completionHandler: SubjectsStoreDeleteSubjectCompletionHandler) {

    }

}
