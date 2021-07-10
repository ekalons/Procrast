//
//  CircularCheckBox.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 6/2/21.
//

import UIKit

class CircularCheckBox: UIView {
    
    private var isChecked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        
        layer.borderColor = UIColor.secondaryLabel.cgColor
        
        layer.cornerRadius = frame.size.width / 2.0
        
        backgroundColor = .systemGray2
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func toggle() {
        self.isChecked = !isChecked
        
        if self.isChecked {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .systemBackground
        }
    }
}
