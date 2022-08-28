//
//  MainPresenter.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 27.08.2022.
//

import Foundation

protocol MainPresenterType {
    func updatePerson(person: Person, name: String, dateOfBirth: String, gender: String)
    func getPersonName() -> String
}

class MainPresenter: MainPresenterType {

    var persons = [Person]()
    var currentPerson = Person()

    let storageManager = StorageManager()

    func fetchAllPerson() {
        persons = storageManager.fetchAllPerson() ?? []
    }

    func savePersonName(name: String) {
        storageManager.savePersonName(name)
    }

    func updatePerson(person: Person, name: String, dateOfBirth: String, gender: String) {
        storageManager.updatePerson(person, name, dateOfBirth, gender)
    }

    func deletePerson(indexPath: IndexPath) {
        storageManager.deletePerson(person: persons[indexPath.row])
    }

    func pushPerson(by indexPath: IndexPath) {
        self.currentPerson = persons[indexPath.row]
    }

    func getPersonName() -> String {
        return currentPerson.name ?? ""
    }
}

