//
//  PCIconButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/18/21.
//

import UIKit

class PCIconButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init() {
        super.init(frame: .zero)
        configure()
    }
    
    func configure() {
        layer.cornerRadius = 15
        setTitle(nil, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }


}
