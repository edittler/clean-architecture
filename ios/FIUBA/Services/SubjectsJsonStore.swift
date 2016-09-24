//
//  SubjectsJsonStore.swift
//  FIUBA
//

import Foundation

class SubjectsJsonStore: SubjectsStoreProtocol {

    // MARK: CRUD operations - Generic enum result type

    func fetchSubjects(_ completionHandler: @escaping SubjectsStoreFetchSubjectsCompletionHandler) {
        DataManager.loadDataFromJsonFile("subjects", success: { (data) in
            var json: Payload!
            do {
                json = try JSONSerialization.jsonObject(with: data,
                    options: JSONSerialization.ReadingOptions()) as? Payload
                guard let subjectsArray = json["subjects"] as? [Payload] else {
                    completionHandler(SubjectsStoreResult.failure(error: SubjectsStoreError.cannotFetch("Cannot fetch subjects")))
                    return
                }
                let subjects = subjectsArray.map({ (dict) -> Subject in
                    let subject = Subject(id: dict["id"] as? String,
                        code: dict["code"] as? String,
                        name: dict["name"] as? String)
                    return subject
                })
                completionHandler(SubjectsStoreResult.success(result: subjects))
            } catch {
                completionHandler(SubjectsStoreResult.failure(error: SubjectsStoreError.cannotFetch("Cannot fetch subjects")))
            }

        })
    }

    func fetchSubject(_ id: String, completionHandler: SubjectsStoreFetchSubjectCompletionHandler) {

    }

    func createSubject(_ subjectToCreate: Subject, completionHandler: SubjectsStoreCreateSubjectCompletionHandler) {

    }

    func createSubjects(_ subjectsToCreate: [Subject], completionHandler: SubjectsStoreCreateSubjectsCompletionHandler) {

    }

    func updateSubject(_ subjectToUpdate: Subject, completionHandler: SubjectsStoreUpdateSubjectCompletionHandler) {

    }

    func deleteSubject(_ id: String, completionHandler: SubjectsStoreDeleteSubjectCompletionHandler) {

    }

}
