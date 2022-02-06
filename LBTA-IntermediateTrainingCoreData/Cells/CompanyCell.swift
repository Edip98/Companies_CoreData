//
//  CompanyCell.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 03.02.2022.
//

import UIKit

class CompanyCell: UITableViewCell {
    
    var company: Company? {
        didSet {
            nameFoundedDateLabel.text = company?.name
            
            if let imageData = company?.imageData {
                companyImageView.image = UIImage(data: imageData)
            }
            
            if let name = company?.name, let founded = company?.founded {
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, yyyy"
                
                let foundedDateString = dateFormatter.string(from: founded)
                
                let dateString = "\(name) - Founded: \(foundedDateString)"
                
                nameFoundedDateLabel.text = dateString
            } else {
                nameFoundedDateLabel.text = company?.name
            }
        }
    }
    
    let companyImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "select_photo"))
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.darkBlue.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameFoundedDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Company name"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .tealCollor
        configureUI()
        //addSubview(nameFoundedDateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI() {
        addSubview(companyImageView)
        addSubview(nameFoundedDateLabel)
        
        NSLayoutConstraint.activate([
            companyImageView.heightAnchor.constraint(equalToConstant: 40),
            companyImageView.widthAnchor.constraint(equalToConstant: 40),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            nameFoundedDateLabel.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 8),
            nameFoundedDateLabel.topAnchor.constraint(equalTo: topAnchor),
            nameFoundedDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameFoundedDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

