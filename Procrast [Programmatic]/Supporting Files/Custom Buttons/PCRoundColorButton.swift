//
//  PCRoundColorButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/21/21.
//

import UIKit

class PCRoundColorButton: UIButton {
    
    var colorPickerAction : (() -> ())?
    
    let colorButtonContentView: UIButton = {
        let view = UIButton()
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 37),
            view.widthAnchor.constraint(equalToConstant: 37)
        ])
        
        return view
    }()

    
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
        
        configureColorButtonContentView()
        
    }
    
    func configureColorButtonContentView() {
        colorButtonContentView.translatesAutoresizingMaskIntoConstraints = false
        
        colorButtonContentView.addTarget(self, action: #selector(onColorButtonTap(_:)), for: .touchUpInside)
        
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
    
    // Selection states
    func colorSelected() {
        print("Color button currently selected")
        colorButtonContentView.layer.borderWidth = 4
        colorButtonContentView.layer.borderColor = UIColor.systemGray3.cgColor
    }
    
    func colorDeselected() {
        print("Color button currently deselected")
        colorButtonContentView.layer.borderWidth = 4
        colorButtonContentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    @objc func onColorButtonTap(_ sender: PCRoundColorButton) {
        
        self.isSelected = !isSelected
        
        if self.isSelected == true {
            colorSelected()
            colorPickerAction?()
        }
        // No else statement, since one color will always be pressed
        
    }
    
}
