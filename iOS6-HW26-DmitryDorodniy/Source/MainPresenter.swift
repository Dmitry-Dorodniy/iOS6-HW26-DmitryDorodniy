//
//  MainPresenter.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 27.08.2022.
//

import Foundation



class MainPresenter {

    
    var contacts = [Person]()
    let storageManager = StorageManager()

    func fetchAllPerson() {
        contacts = storageManager.fetchAllPerson() ?? []
    }

    func savePersonName(name: String) {
        storageManager.savePersonName(name)
    }

    func updatePerson(name: String, dateOfBirth: Date, gender: String) {
        storageManager.savePerson(name, dateOfBirth, gender)
    }

    func deletePerson(indexPath: IndexPath) {
        storageManager.deletePerson(person: contacts[indexPath.row])
    }

    func pushPerson(indexPath: IndexPath) {
      
    }
}
