//
//  DetailViewController.swift
//  iOS6-HW26-DmitryDorodniy
//
//  Created by Dmitry Dorodniy on 15.08.2022.
//

import UIKit

class DetailViewController: UIViewController {

    private var isEdit = Bool()
    private let genders = ["male", "female", "not human"]

    var presenter: DetailPresenterType?

    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.layer.borderWidth = 1.5
        button.layer.masksToBounds = true
        var config = UIButton.Configuration.borderedTinted()
        config.titleAlignment = .center
        button.configuration = config
        button.addTarget(self, action: #selector(editButtonPressed), for: .allEvents)
        return button
    }()

    private lazy var avatarImageButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "face"), for: .normal)
//        button.imageView?.clipsToBounds = true
        button.imageView?.layer.masksToBounds = true
        button.imageView?.layer.cornerRadius = 100
        button.imageView?.contentMode = .scaleAspectFill
        button.isUserInteractionEnabled = false
//        imageView.image = UIImage(named: "face")
        return button
    }()

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        let name = presenter?.person?.name
        textField.setting(systemImage: "person", text: name ?? "")

        return textField
    }()

    private lazy var dateOfBirthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input your date of birdth"
        let date = presenter?.person?.dateOfBirth?.convertToString()
            textField.setting(systemImage: "calendar", text: date ?? "")

        textField.datePicker(target: self,
                             doneAction: #selector(doneAction),
                             cancelAction: #selector(cancelAction))
        return textField
    }()

    private lazy var genderTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Choose your gender"
        let gender = presenter?.person?.gender ?? ""
        textField.setting(systemImage: "person.2.circle",
                          text: gender)
        textField.inputView = genderPikerView
        return textField
    }()

    private lazy var genderPikerView: UIPickerView = {
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 130))
//        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self

        return picker
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

//        contacts = storageManager.fetchAllPerson() ?? []
    }

// MARK: - Setup functions
    private func setupView() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: editButton)
        setupEditButton(title: "Edit", borderColor: .lightGray)
    }

    private func setupHierarchy() {
        view.addSubview(avatarImageButton)
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

        avatarImageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
           make.height.width.equalTo(200)
        }

        dataStackView.snp.makeConstraints { make in
            make.top.equalTo(avatarImageButton.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }

     setUnderlineView(lineUnderNameTextField, under: nameTextField)
        setUnderlineView(lineUnderDateOfBirthTextField, under: dateOfBirthTextField)
        setUnderlineView(lineUnderGenderTextField, under: genderTextField)
    }

    private func setupEditButton(title: String, borderColor: UIColor) {
        editButton.setTitle(title, for: .normal)
        editButton.layer.borderColor = borderColor.cgColor
    }

    private func saveData() {
        presenter?.updatePerson(name: nameTextField.text ?? "", dateOfBirth: dateOfBirthTextField.text ?? "", gender: genderTextField.text ?? "")
    }

    // MARK: - OBJC Functions

    @objc
    func editButtonPressed() {

        isEdit.toggle()
        if isEdit {
            setupEditButton(title: "Save", borderColor: .red)
            avatarImageButton.isUserInteractionEnabled = true
            nameTextField.isUserInteractionEnabled = true
            dateOfBirthTextField.isUserInteractionEnabled = true
            genderTextField.isUserInteractionEnabled = true
//            editButton.setTitle("Save", for: .normal)
//            editButton.layer.borderColor = UIColor.red.cgColor
        } else {
            setupEditButton(title: "Edit", borderColor: .lightGray)
            avatarImageButton.isUserInteractionEnabled = false
            nameTextField.isUserInteractionEnabled = false
            dateOfBirthTextField.isUserInteractionEnabled = false
            doneAction()
            saveData()
            genderTextField.isUserInteractionEnabled = false
        }
    }

    @objc
    func cancelAction() {
        self.dateOfBirthTextField.resignFirstResponder()
    }

    @objc
    func doneAction() {

        if let datePickerView = self.dateOfBirthTextField.inputView as? UIDatePicker {
            self.dateOfBirthTextField.text = datePickerView.date.convertToString()
            self.dateOfBirthTextField.resignFirstResponder()
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderTextField.text = genders[row]
    }


}

//extension DetailViewController: UITextFieldDelegate {
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//        if !isEdit {
//        if textField == nameTextField {
//            return false; //do not show keyboard nor cursor
//        }
//        }
//        return true
//    }
//}
