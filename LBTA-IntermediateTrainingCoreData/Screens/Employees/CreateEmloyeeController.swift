//
//  CreateEmloyeeController.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 03.02.2022.
//

import UIKit

protocol CreateEmloyeeControllerDelegate {
    func didAddEmployee(employee: Employee)
}

class CreateEmloyeeController: UIViewController {
    
    var company: Company?
    
    var delegate: CreateEmloyeeControllerDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let birhdayLabel: UILabel = {
        let label = UILabel()
        label.text = "Bithday"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let birthdayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "MM/dd/yyyy"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let employeeTypeSegmentedControlor: UISegmentedControl = {
        let types = [
            EmployeeType.Executive.rawValue,
            EmployeeType.SeniorManagment.rawValue,
            EmployeeType.Staff.rawValue
        ]
        let sc = UISegmentedControl(items: types)
        sc.selectedSegmentIndex = 0
        sc.selectedSegmentTintColor = .darkBlue
        sc.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkBlue
        navigationItem.title = "Create Employee"
        setupCancelButton()
        let _ = setupLightBlueBackgroundView(height: 150)
        setupUI()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        guard let emoloyeeName = nameTextField.text else { return }
        guard let company = self.company else { return }
        
        guard let birthdayText = birthdayTextField.text else { return }
        
        if birthdayText.isEmpty {
            showError(title: "Empty Birthday", message: "You have not enter a birthday.")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        guard let birthdayDate = dateFormatter.date(from: birthdayText)
            else {
            showError(title: "Bad Date", message: "Birthday date entered not valid.")
            return
        }
        
        
        guard let emloyeeType = employeeTypeSegmentedControlor.titleForSegment(at: employeeTypeSegmentedControlor.selectedSegmentIndex) else { return }
        
        let tuple = CoreDataManager.shared.createEmployee(employeeName: emoloyeeName, employeeType: emloyeeType, birthday: birthdayDate , company: company)
        
        if let error = tuple.1 {
            //is where you present an error alert
            print(error)
        } else {
            dismiss(animated: true) {
                self.delegate?.didAddEmployee(employee: tuple.0!)
            }
        }
    }
    
    
    private func showError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    private func setupUI() {
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(birhdayLabel)
        view.addSubview(birthdayTextField)
        view.addSubview(employeeTypeSegmentedControlor)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            
            birhdayLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            birhdayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            birhdayLabel.widthAnchor.constraint(equalToConstant: 100),
            birhdayLabel.heightAnchor.constraint(equalToConstant: 50),
            
            birthdayTextField.topAnchor.constraint(equalTo: birhdayLabel.topAnchor),
            birthdayTextField.leadingAnchor.constraint(equalTo: birhdayLabel.trailingAnchor),
            birthdayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            birthdayTextField.bottomAnchor.constraint(equalTo: birhdayLabel.bottomAnchor),
            
            employeeTypeSegmentedControlor.topAnchor.constraint(equalTo: birhdayLabel.bottomAnchor),
            employeeTypeSegmentedControlor.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            employeeTypeSegmentedControlor.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            employeeTypeSegmentedControlor.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
}
