//
//  DetailViewController.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 15.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    var isEdit = Bool()

//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//
//    }

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

//    private lazy var spacingView: UIView = {
//        let view = UIView()
//        view.setContentHuggingPriority(.defaultLow, for: .horizontal)
//        return view
//    }()

//    private lazy var nameImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.tintColor = .lightGray
//        imageView.image = UIImage(systemName: "person")
//        return imageView
//    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.setting(systemImage: "person", text: "Яна Брбсва")
//        textField.isUserInteractionEnabled = false
////        textField.delegate = self
//        textField.leftViewMode = .always
//        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        imageView.tintColor = .lightGray
//        let image = UIImage(systemName: "person")
//        imageView.image = image
//        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0,
//                                                             width: imageView.frame.width + 20,
//                                                             height: imageView.frame.height + 10))
//        iconContainerView.addSubview(imageView)
//        textField.leftView = iconContainerView
//        textField.text = "Вася Пупкин"
        return textField
    }()

    lazy var birthdayDatePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = Date.now
        datePicker.datePickerMode = .date
        datePicker.isEnabled = true
        return datePicker
    }()

    private lazy var dateOfBirthTextField: UITextField = {

        let textField = UITextField()
        textField.setting(systemImage: "calendar", text: "10.23.4544")
        textField.inputView = birthdayDatePicker
//        textField.leftViewMode = .always
//        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        imageView.tintColor = .lightGray
//        let image = UIImage(systemName: "calendar")
//        imageView.image = image
//        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0,
//                                                             width: imageView.frame.width + 20,
//                                                             height: imageView.frame.height + 10))
//        iconContainerView.addSubview(imageView)
//        textField.leftView = iconContainerView
//        textField.text = "10.23.4544"
        return textField
    }()

    private lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.setting(systemImage: "person.2.circle", text: "female")
//        textField.leftViewMode = .always
//        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
//        imageView.contentMode = .scaleAspectFit
//        imageView.tintColor = .lightGray
//        let image = UIImage(systemName: "person.2.circle")
//        imageView.image = image
//        let iconContainerView: UIView = UIView(frame: CGRect(x: 0, y: 0,
//                                                             width: imageView.frame.width + 20,
//                                                             height: imageView.frame.height + 10))
//        iconContainerView.addSubview(imageView)
//        textField.leftView = iconContainerView
//        textField.text = "female"
        return textField
    }()

    private lazy var lineUnderNameTextField: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var lineUnderDateOfBirthTextField: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()

    private lazy var lineUnderGenderTextField: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }()


//    private lazy var textFieldStackView: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .horizontal
//        stack.spacing = 10
//        stack.distribution = .fillProportionally
//        stack.alignment = .center
//        [self.nameImageView,
//            self.nameTextField,
//         self.spacingView].forEach { stack.addArrangedSubview($0) }
//        return stack
//    }()

    private lazy var dataStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        stack.alignment = .fill
        [nameTextField,
        dateOfBirthTextField,
        genderTextField].forEach { stack.addArrangedSubview($0) }
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
        view.addSubview(lineUnderNameTextField)
        view.addSubview(lineUnderDateOfBirthTextField)
        view.addSubview(lineUnderGenderTextField)

    }


    private func setupLayout() {

        func setUnderlineView(_ lineView: UIView, under: UIView) {
            lineView.snp.makeConstraints { make in
                make.leading.trailing.equalTo(dataStackView)
                make.top.equalTo(under.snp.bottom)
                make.height.equalTo(2)
            }
        }

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
            make.height.equalTo(150)
        }

     setUnderlineView(lineUnderNameTextField, under: nameTextField)
        setUnderlineView(lineUnderDateOfBirthTextField, under: dateOfBirthTextField)
        setUnderlineView(lineUnderGenderTextField, under: genderTextField)

//        lineUnderDateOfBirthTextField.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(dataStackView)
//            make.top.equalTo(dateOfBirthTextField.snp.bottom)
//            make.height.equalTo(2)
//        }
//
//        lineUnderGenderTextField.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(dataStackView)
//            make.top.equalTo(genderTextField.snp.bottom)
//            make.height.equalTo(2)
//        }
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
            nameTextField.isUserInteractionEnabled = true
            dateOfBirthTextField.isUserInteractionEnabled = true
            genderTextField.isUserInteractionEnabled = true
//            editButton.setTitle("Save", for: .normal)
//            editButton.layer.borderColor = UIColor.red.cgColor
        } else {
            setupEditButton(title: "Edit", borderColor: .lightGray)
            nameTextField.isUserInteractionEnabled = false
            dateOfBirthTextField.isUserInteractionEnabled = false
            genderTextField.isUserInteractionEnabled = false
//            editButton.setTitle("Edit", for: .normal)
//            editButton.layer.borderColor = UIColor.lightGray.cgColor
        }
    }

}

extension DetailViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !isEdit {
        if textField == nameTextField {
            return false; //do not show keyboard nor cursor
        }
        }
        return true
    }
}
