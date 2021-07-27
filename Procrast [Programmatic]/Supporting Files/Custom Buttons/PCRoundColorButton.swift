//
//  PCRoundColorButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/21/21.
//

import UIKit

class PCRoundColorButton: UIView {
    
    let colorButtonContentView: UIView = {
        let view = UIView()
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 37),
            view.widthAnchor.constraint(equalToConstant: 37)
        ])
        
        return view
    }()
    
    var buttonColor: UIColor = UIColor()
    
    let selectionRing = UIView()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        self.addSubview(colorButtonContentView)
        colorButtonContentView.addSubview(selectionRing)
        
        configureColorButtonContentView()
        
    }
    
    func configureColorButtonContentView() {
        colorButtonContentView.translatesAutoresizingMaskIntoConstraints = false
        
        colorButtonContentView.backgroundColor = .systemBlue
        colorButtonContentView.layer.cornerRadius = 18
        colorButtonContentView.layer.borderWidth = 4
        colorButtonContentView.layer.borderColor = UIColor.clear.cgColor
        
        
        NSLayoutConstraint.activate([
            colorButtonContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            colorButtonContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            colorButtonContentView.heightAnchor.constraint(equalToConstant: 37),
            colorButtonContentView.widthAnchor.constraint(equalToConstant: 37)
        ])
        
    }
    
    func colorSelected() {
        print("Color button currently selected")
        colorButtonContentView.backgroundColor = UIColor.systemRed
        selectionRing.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func colorDeselected() {
        print("Color button currently deselected")
        colorButtonContentView.backgroundColor = UIColor.systemRed
        selectionRing.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    
}
