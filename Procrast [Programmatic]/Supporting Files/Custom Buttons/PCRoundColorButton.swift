//
//  PCRoundColorButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/21/21.
//

import UIKit

class PCRoundColorButton: UIButton {
    
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
        backgroundColor = .systemBlue
        
        
        layer.cornerRadius = 19
    }

    
}
