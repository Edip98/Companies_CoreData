//
//  CompaniesController+UITableView.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 03.02.2022.
//

import UIKit

extension CompaniesController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let company = self.companies[indexPath.row]
        let employeesController = EmployeesController()
        employeesController.company = company
        navigationController?.pushViewController(employeesController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title:  "Delete") { action, _, _ in
            let company = self.companies[indexPath.row]
            
            self.companies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
            let context = CoreDataManager.shared.persistentConatainer.viewContext
            context.delete(company)
            
            do {
                try context.save()
            } catch let saveError {
                print("Failed to delete company:", saveError)
            }
        }
        deleteAction.backgroundColor = UIColor.lightRed
        
        let editAction = UIContextualAction(style: .normal, title:  "Edit") { action, _, _ in
            let editCompanyController = CreateCompanyController()
            
            editCompanyController.delegate = self
            editCompanyController.company = self.companies[indexPath.row]
            
            let navController = UINavigationController(rootViewController: editCompanyController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true, completion: nil)
        }
        editAction.backgroundColor = UIColor.darkBlue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let label = UILabel()
        label.text = "No companies available..."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return companies.count == 0 ? 150 : 0
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .lightBlue
        return view
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
 

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CompanyCell
        let company = companies[indexPath.row]
        cell.company = company
        return cell
    }
}
