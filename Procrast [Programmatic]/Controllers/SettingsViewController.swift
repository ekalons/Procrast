//
//  SettingsViewController.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/18/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let leavePageButton = PCIconButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.defaultBackgroundColor
        
        configureUI()

        
    }
    
    
    func configureUI() {
        configureLeavePageButton()
        
    }
    
    func configureLeavePageButton() {
        leavePageButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leavePageButton)
        leavePageButton.setImage(Icons.chevronIcon, for: .normal)
        leavePageButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            leavePageButton.heightAnchor.constraint(equalToConstant: 30),
            leavePageButton.widthAnchor.constraint(equalToConstant: 31),
            leavePageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19),
            leavePageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])
    }
    
    @objc func backToMainVC() {
        //Add completion parameter to dismiss() to pass data back to MainVC
        dismiss(animated: true)
    }
}


