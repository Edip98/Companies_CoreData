//
//  CompaniesController.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 02.02.2022.
//

import UIKit
import CoreData

class CompaniesController: UITableViewController {
    
    var companies = [Company]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigationStyle()
        configureTableView()
        self.companies = CoreDataManager.shared.fetchCompanies()
    }
    
    
    @objc private func handleAddCompany() {
        let createCompanyController = CreateCompanyController()
        
        let navController = UINavigationController(rootViewController: createCompanyController)
        
        present(navController, animated: true, completion: nil)
        
        createCompanyController.delegate = self
    }
    
    @objc private func handleReset() {
        let context = CoreDataManager.shared.persistentConatainer.viewContext
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: Company.fetchRequest())
        
        do {
            try context.execute(batchDeleteRequest)
            
            var indexPathsToRemove = [IndexPath]()
            
            for(index, _) in companies.enumerated() {
                let indexPath = IndexPath(row: index, section: 0)
                indexPathsToRemove.append(indexPath)
            }
            companies.removeAll()
            DispatchQueue.main.async {
                self.tableView.deleteRows(at: indexPathsToRemove, with: .left)
            }
        } catch let deleteError {
            print("Failed to delete objects from Core Data", deleteError)
        }
    }
    
    
    func configureTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .darkBlue
        tableView.register(CompanyCell.self, forCellReuseIdentifier: "cellId")
        tableView.separatorColor = .white
    }
    
    
    func configureNavigationStyle() {
        navigationItem.title = "Companies"
        setupPlusButtonAndNavBar(selectorr: #selector(handleAddCompany))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(handleReset))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
    }
}
