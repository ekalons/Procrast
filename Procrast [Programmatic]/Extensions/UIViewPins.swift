//
//  UIViewPins.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 3/19/21.
//

import UIKit

extension UIView {
    
    
    func pinToEdges(to superView: UIView) {
        translatesAutoresizingMaskIntoConstraints                                           = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive                         = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive                 = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive               = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -75).isActive    = true
    }
}
