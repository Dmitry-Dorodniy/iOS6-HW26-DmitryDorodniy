//
//  DetailViewController.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 15.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var isEdit = Bool()

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
//        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.masksToBounds = true
//        button.setTitle("Edit", for: .normal)
        var config = UIButton.Configuration.borderedTinted()
        config.titleAlignment = .center
//        config.title = "Edit"
//        config.cornerStyle = .large
        button.configuration = config
        button.addTarget(self, action: #selector(editButtonPressed), for: .allEvents)
        return button
    }()

    private lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "face")
        return imageView
    }()

    private lazy var nameImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.image = UIImage(systemName: "person")
        return imageView
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
//        textField.borderStyle = .roundedRect
        textField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        let image = UIImage(systemName: "person")
        imageView.image = image
        textField.leftView = imageView
        textField.text = "dfdfdfdf"
        return textField
    }()

    private lazy var textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.alignment = .center
        [self.nameImageView,
            self.nameTextField].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    private lazy var dataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .equalSpacing
        stack.alignment = .fill
        [self.textFieldStackView].forEach { stack.addArrangedSubview($0) }
        return stack
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHierarchy()
        setupLayout()
    }

    private func setupView() {
        view.backgroundColor = .systemBackground

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        setupEditButton(title: "Edit", borderColor: .lightGray)
    }

    private func setupHierarchy() {
        view.addSubview(avatarImage)
        view.addSubview(dataStackView)
    }

    private func setupLayout() {

        editButton.snp.makeConstraints { make in
            make.width.equalTo(70)
        }

        avatarImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
           make.height.width.equalTo(200)
        }

        dataStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }

    private func setupEditButton(title: String, borderColor: UIColor) {
        editButton.setTitle(title, for: .normal)
        editButton.layer.borderColor = borderColor.cgColor
    }

    @objc func editButtonPressed() {
print("edit")
        isEdit.toggle()
        if isEdit {
            setupEditButton(title: "Save", borderColor: .red)
//            editButton.setTitle("Save", for: .normal)
//            editButton.layer.borderColor = UIColor.red.cgColor
        } else {
            setupEditButton(title: "Edit", borderColor: .lightGray)
//            editButton.setTitle("Edit", for: .normal)
//            editButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}
