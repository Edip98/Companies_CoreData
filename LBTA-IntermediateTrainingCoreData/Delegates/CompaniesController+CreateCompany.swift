//
//  CompaniesController+CreateCompany.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 03.02.2022.
//

import Foundation

extension CompaniesController: CreateCompanyControllerDelegate {
    
    func didEditCompany(company: Company) {
        let row = companies.firstIndex(of: company)
        let reloadIndexPath = IndexPath(row: row!, section: 0)
        DispatchQueue.main.async {
            self.tableView.reloadRows(at: [reloadIndexPath], with: .middle)
        }
    }
    
    
    func didAddCompany(company: Company) {
        companies.append(company)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
