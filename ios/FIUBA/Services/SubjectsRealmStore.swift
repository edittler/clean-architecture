//
//  SubjectsRealmStore.swift
//  FIUBA
//

import RealmSwift

class SubjectsRealmStore: SubjectsStoreProtocol {

    func fetchSubjects(_ completionHandler: @escaping SubjectsStoreFetchSubjectsCompletionHandler) {
        guard let realm = realm() else {
            completionHandler(SubjectsStoreResult.failure(error: SubjectsStoreError.cannotFetch("No se pudo instanciar Realm")))
            return
        }

        let rlmSubjects = realm.objects(SubjectRLM.self)
        let subjects: [Subject] = rlmSubjects.map { (rlmSubject) -> Subject in
            return Subject(id: rlmSubject.id,
                code: rlmSubject.code,
                name: rlmSubject.name)
        }
        completionHandler(SubjectsStoreResult.success(result: subjects))
    }

    func fetchSubject(_ id: String, completionHandler: SubjectsStoreFetchSubjectCompletionHandler) {

    }

    func createSubject(_ subjectToCreate: Subject, completionHandler: SubjectsStoreCreateSubjectCompletionHandler) {

    }

    func createSubjects(_ subjects: [Subject], completionHandler: SubjectsStoreCreateSubjectsCompletionHandler) {
        guard let realm = realm() else {
            completionHandler(SubjectsStoreResult.failure(error: SubjectsStoreError.cannotCreate("No se pudo instanciar Realm")))
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
            completionHandler(SubjectsStoreResult.failure(error: SubjectsStoreError.cannotCreate("No se pudo escribir en Realm")))
            return
        }
        completionHandler(SubjectsStoreResult.success(result: ()))
    }

    func updateSubject(_ subjectToUpdate: Subject, completionHandler: SubjectsStoreUpdateSubjectCompletionHandler) {

    }

    func deleteSubject(_ id: String, completionHandler: SubjectsStoreDeleteSubjectCompletionHandler) {

    }

    // MARK: - Auxiliars

    fileprivate func realm() -> Realm? {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }
    
}
