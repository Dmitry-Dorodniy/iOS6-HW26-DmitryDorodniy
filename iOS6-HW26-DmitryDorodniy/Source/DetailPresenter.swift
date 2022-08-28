//
//  DetailPresenter.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 28.08.2022.
//

import Foundation

protocol DetailPresenterType {
    var person: Person? { get set }
    init (person: Person, storage: StorageManagerType)
    func updatePerson(person: Person, name: String, dateOfBirth: String, gender: String)
}

class DetailPresenter: DetailPresenterType {
    var person: Person?

    required init(person: Person, storage: StorageManagerType) {
        self.person = person
        storageManager = storage
    }

    let storageManager: StorageManagerType

    func updatePerson(person: Person, name: String, dateOfBirth: String, gender: String) {
    storageManager.updatePerson(person, name, dateOfBirth, gender)
}

}
