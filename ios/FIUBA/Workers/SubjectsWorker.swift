//
//  SubjectsWorker.swift
//  FIUBA
//

import Foundation

class SubjectsWorker {

    var subjectsStore: SubjectsStoreProtocol

    init(subjectsStore: SubjectsStoreProtocol) {
        self.subjectsStore = subjectsStore
    }

    func fetchSubjects(_ completionHandler: @escaping (_ subjects: [Subject]) -> Void) {
        subjectsStore.fetchSubjects { (result) in
            switch result {
            case .success(let subjects):
                completionHandler(subjects)
            case .failure( _):
                completionHandler([])
            }
        }
    }

    func createSubjects(_ subjectsToCreate: [Subject]) {
        subjectsStore.createSubjects(subjectsToCreate) { (result) in
        }
    }

}

protocol SubjectsStoreProtocol {

    // MARK: CRUD operations - Generic enum result type

    func fetchSubjects(_ completionHandler: @escaping SubjectsStoreFetchSubjectsCompletionHandler)
    func fetchSubject(_ id: String, completionHandler: SubjectsStoreFetchSubjectCompletionHandler)
    func createSubject(_ subjectToCreate: Subject, completionHandler: SubjectsStoreCreateSubjectCompletionHandler)
    func createSubjects(_ subjectsToCreate: [Subject], completionHandler: SubjectsStoreCreateSubjectsCompletionHandler)
    func updateSubject(_ subjectToUpdate: Subject, completionHandler: SubjectsStoreUpdateSubjectCompletionHandler)
    func deleteSubject(_ id: String, completionHandler: SubjectsStoreDeleteSubjectCompletionHandler)

}

// MARK: - Subjects store CRUD operation results

typealias SubjectsStoreFetchSubjectsCompletionHandler = (_ result: SubjectsStoreResult<[Subject]>) -> Void
typealias SubjectsStoreFetchSubjectCompletionHandler = (_ result: SubjectsStoreResult<Subject>) -> Void
typealias SubjectsStoreCreateSubjectCompletionHandler = (_ result: SubjectsStoreResult<Void>) -> Void
typealias SubjectsStoreCreateSubjectsCompletionHandler = (_ result: SubjectsStoreResult<Void>) -> Void
typealias SubjectsStoreUpdateSubjectCompletionHandler = (_ result: SubjectsStoreResult<Void>) -> Void
typealias SubjectsStoreDeleteSubjectCompletionHandler = (_ result: SubjectsStoreResult<Void>) -> Void

enum SubjectsStoreResult<U> {
    case success(result: U)
    case failure(error: SubjectsStoreError)
}

// MARK: - Subjects store CRUD operation errors

enum SubjectsStoreError: Equatable, Error {
    case cannotFetch(String)
    case cannotCreate(String)
    case cannotUpdate(String)
    case cannotDelete(String)
}

func==(lhs: SubjectsStoreError, rhs: SubjectsStoreError) -> Bool {
    switch (lhs, rhs) {
    case (.cannotFetch(let a), .cannotFetch(let b)) where a == b: return true
    case (.cannotCreate(let a), .cannotCreate(let b)) where a == b: return true
    case (.cannotUpdate(let a), .cannotUpdate(let b)) where a == b: return true
    case (.cannotDelete(let a), .cannotDelete(let b)) where a == b: return true
    default: return false
    }
}
