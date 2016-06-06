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

    func fetchSubjects(completionHandler: (subjects: [Subject]) -> Void) {
        subjectsStore.fetchSubjects { (result) in
            switch result {
            case .Success(let subjects):
                completionHandler(subjects: subjects)
            case .Failure( _):
                completionHandler(subjects: [])
            }
        }
    }

    func createSubjects(subjectsToCreate: [Subject]) {
        subjectsStore.createSubjects(subjectsToCreate) { (result) in
        }
    }

}

protocol SubjectsStoreProtocol {

    // MARK: CRUD operations - Generic enum result type

    func fetchSubjects(completionHandler: SubjectsStoreFetchSubjectsCompletionHandler)
    func fetchSubject(id: String, completionHandler: SubjectsStoreFetchSubjectCompletionHandler)
    func createSubject(subjectToCreate: Subject, completionHandler: SubjectsStoreCreateSubjectCompletionHandler)
    func createSubjects(subjectsToCreate: [Subject], completionHandler: SubjectsStoreCreateSubjectsCompletionHandler)
    func updateSubject(subjectToUpdate: Subject, completionHandler: SubjectsStoreUpdateSubjectCompletionHandler)
    func deleteSubject(id: String, completionHandler: SubjectsStoreDeleteSubjectCompletionHandler)

}

// MARK: - Subjects store CRUD operation results

typealias SubjectsStoreFetchSubjectsCompletionHandler = (result: SubjectsStoreResult<[Subject]>) -> Void
typealias SubjectsStoreFetchSubjectCompletionHandler = (result: SubjectsStoreResult<Subject>) -> Void
typealias SubjectsStoreCreateSubjectCompletionHandler = (result: SubjectsStoreResult<Void>) -> Void
typealias SubjectsStoreCreateSubjectsCompletionHandler = (result: SubjectsStoreResult<Void>) -> Void
typealias SubjectsStoreUpdateSubjectCompletionHandler = (result: SubjectsStoreResult<Void>) -> Void
typealias SubjectsStoreDeleteSubjectCompletionHandler = (result: SubjectsStoreResult<Void>) -> Void

enum SubjectsStoreResult<U> {
    case Success(result: U)
    case Failure(error: SubjectsStoreError)
}

// MARK: - Subjects store CRUD operation errors

enum SubjectsStoreError: Equatable, ErrorType {
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
}

func==(lhs: SubjectsStoreError, rhs: SubjectsStoreError) -> Bool {
    switch (lhs, rhs) {
    case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
    case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
    case (.CannotUpdate(let a), .CannotUpdate(let b)) where a == b: return true
    case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
    default: return false
    }
}
