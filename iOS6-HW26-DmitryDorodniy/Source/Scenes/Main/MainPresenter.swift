//
//  MainPresenter.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 27.08.2022.
//

import Foundation

protocol MainPresenterType {
    var persons: [Person] { get set }
    var router: RouterType? { get }
    func fetchAllPerson()
    func savePersonName(name: String)
    func deletePerson(indexPath: IndexPath)
    func pushPerson(by indexPath: IndexPath) 
    init(router: RouterType?, storage: StorageManagerType)

}

class MainPresenter: MainPresenterType {

    var router: RouterType?

    required init(router: RouterType?, storage: StorageManagerType) {
        self.router = router
        self.storageManager = storage
    }


    var persons = [Person]()

    var storageManager: StorageManagerType

    func fetchAllPerson() {
        persons = storageManager.fetchAllPerson() ?? []
    }

    func savePersonName(name: String) {
        storageManager.savePersonName(name)
    }

    func updatePerson(person: Person, avatar: Data, name: String, dateOfBirth: String, gender: String) {
        storageManager.updatePerson(person, avatar, name, dateOfBirth, gender)
    }

    func deletePerson(indexPath: IndexPath) {
        storageManager.deletePerson(person: persons[indexPath.row])
    }

    func pushPerson(by indexPath: IndexPath) {
        router?.pushDetail(person: persons[indexPath.row])
    }


}

