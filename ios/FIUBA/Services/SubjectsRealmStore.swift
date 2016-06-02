//
//  SubjectsRealmStore.swift
//  FIUBA
//

import RealmSwift

class SubjectsRealmStore: SubjectsStoreProtocol {

    func fetchSubjects(completionHandler: SubjectsStoreFetchSubjectsCompletionHandler) {
        guard let realm = realm() else {
            completionHandler(result: SubjectsStoreResult.Failure(error: SubjectsStoreError.CannotFetch("No se pudo instanciar Realm")))
            return
        }

        let rlmSubjects = realm.objects(SubjectRLM)
        let subjects: [Subject] = rlmSubjects.map { (rlmSubject) -> Subject in
            return Subject(id: rlmSubject.id,
                code: rlmSubject.code,
                name: rlmSubject.name)
        }
        completionHandler(result: SubjectsStoreResult.Success(result: subjects))
    }

    func fetchSubject(id: String, completionHandler: SubjectsStoreFetchSubjectCompletionHandler) {

    }

    func createSubject(subjectToCreate: Subject, completionHandler: SubjectsStoreCreateSubjectCompletionHandler) {

    }

    func createSubjects(subjects: [Subject], completionHandler: SubjectsStoreCreateSubjectsCompletionHandler) {
        guard let realm = realm() else {
            completionHandler(result: SubjectsStoreResult.Failure(error: SubjectsStoreError.CannotCreate("No se pudo instanciar Realm")))
            return
        }

        let rlmSubjects: [SubjectRLM] = subjects.map { (subject) -> SubjectRLM in
            let rlmSubject = SubjectRLM()
            rlmSubject.id = subject.id ?? ""
            rlmSubject.code = subject.code ?? ""
            rlmSubject.name = subject.name ?? ""
            return rlmSubject
        }
        do {
            try realm.write {
                for subject in rlmSubjects {
                    realm.add(subject)
                }
            }
        } catch {
            completionHandler(result: SubjectsStoreResult.Failure(error: SubjectsStoreError.CannotCreate("No se pudo escribir en Realm")))
            return
        }
        completionHandler(result: SubjectsStoreResult.Success(result: ()))
    }

    func updateSubject(subjectToUpdate: Subject, completionHandler: SubjectsStoreUpdateSubjectCompletionHandler) {

    }

    func deleteSubject(id: String, completionHandler: SubjectsStoreDeleteSubjectCompletionHandler) {

    }

    // MARK: - Auxiliars

    private func realm() -> Realm? {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }
    
}
