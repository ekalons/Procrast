//
//  PCCompletedHabitButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 6/2/21.
//

import UIKit

class PCCompletedHabitButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton() {
        setTitle(nil, for: .normal)
        
        layer.cornerRadius = 15
    }

    
}
