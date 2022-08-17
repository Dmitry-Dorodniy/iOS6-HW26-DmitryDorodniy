//
//  DetailViewController.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 15.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
        var config = UIButton.Configuration.borderedTinted()
        config.titleAlignment = .center
        config.title = "Edit"
//        config.cornerStyle = .large
        button.configuration = config
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
    }

    @objc func editButtonPressed() {
print("edit")
    }

}
