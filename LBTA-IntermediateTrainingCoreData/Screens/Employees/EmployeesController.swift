//
//  EmployeesController.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 03.02.2022.
//

import UIKit
import CoreData


class IndentedLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let customRect = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        super.drawText(in: rect.inset(by: customRect))
    }
    
}

class EmployeesController: UITableViewController, CreateEmloyeeControllerDelegate {
    
    var company: Company?
    
    let cellId = "EmployeesControllerCellId"
    
    var shortNameEmloyee = [Employee]()
    var longNameEmloyee = [Employee]()
    var reallyLongNameEmloyee = [Employee]()
    
    var allEmloyees = [[Employee]]()
    
    var employeeTypes = [
        EmployeeType.Executive.rawValue,
        EmployeeType.SeniorManagment.rawValue,
        EmployeeType.Staff.rawValue
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = company?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .darkBlue
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupPlusButtonAndNavBar(selectorr: #selector(handleAdd))
        fetchEmployees()
    }
    
    func didAddEmployee(employee: Employee) {
        
        guard let section = employeeTypes.firstIndex(of: employee.type!) else { return }
        let row = allEmloyees[section].count
        let insertIndexPath = IndexPath(row: row, section: section)
        
        allEmloyees[section].append(employee)
        tableView.insertRows(at: [insertIndexPath], with: .middle)
    }
    
    private func fetchEmployees() {
        
        guard let companyEmloyees = company?.employees?.allObjects as? [Employee] else { return }
        
        allEmloyees = []
        
        employeeTypes.forEach { employeeType in
            allEmloyees.append(
                companyEmloyees.filter( {$0.type == employeeType} )
            )
        }
    }
    
    
    @objc private func handleAdd() {
        let createEmloyeeController = CreateEmloyeeController()
        createEmloyeeController.delegate = self
        createEmloyeeController.company = company
        let navController = UINavigationController(rootViewController: createEmloyeeController)
        present(navController, animated: true, completion: nil)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allEmloyees.count
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = IndentedLabel()
        
        label.text = employeeTypes[section]
        
        
        label.backgroundColor = UIColor.lightBlue
        label.textColor = UIColor.darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allEmloyees[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
       // let emloyee = employee[indexPath.row]
        
        //let employee = indexPath.section == 0 ? shortNameEmloyee[indexPath.row] : longNameEmloyee[indexPath.row]
        
        let employee = allEmloyees[indexPath.section][indexPath.row]
        
        if let birthday = employee.birthday {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            cell.textLabel?.text = "\(employee.name ?? "")    \(dateFormatter.string(from: birthday))"
        }
        
        cell.backgroundColor = UIColor.tealCollor
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        return cell
    }
}
