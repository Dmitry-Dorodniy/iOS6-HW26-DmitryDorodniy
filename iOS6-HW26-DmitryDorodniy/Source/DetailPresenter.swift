//
//  DetailPresenter.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 28.08.2022.
//

import Foundation

class DetailPresenter {

var contact = Person()
    let storageManager = StorageManager()

    func updatePerson(person: Person, name: String, dateOfBirth: String, gender: String) {
    storageManager.updatePerson(person, name, dateOfBirth, gender)
}

}
