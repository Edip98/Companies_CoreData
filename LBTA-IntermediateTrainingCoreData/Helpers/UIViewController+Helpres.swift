//
//  UIViewController+Helpres.swift
//  LBTA-IntermediateTrainingCoreData
//
//  Created by Эдип on 03.02.2022.
//

import UIKit

extension UIViewController {
    
    func setupPlusButtonAndNavBar(selectorr: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: self, action: selectorr)
    }
    
    func setupCancelButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancelModal))
    }
    
    
    @objc func handleCancelModal() {
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupLightBlueBackgroundView(height: CGFloat) -> UIView {
        let lighBlueBackgroundView = UIView()
        lighBlueBackgroundView.backgroundColor = .lightBlue
        lighBlueBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(lighBlueBackgroundView)
        
        NSLayoutConstraint.activate([
            lighBlueBackgroundView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            lighBlueBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lighBlueBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lighBlueBackgroundView .heightAnchor.constraint(equalToConstant: height)
        ])
        
        return lighBlueBackgroundView
    }
}
