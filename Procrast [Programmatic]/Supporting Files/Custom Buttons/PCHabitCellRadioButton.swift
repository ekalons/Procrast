//
//  PCHabitCellRadioButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz Alonso on 7/23/21.
//

import UIKit

class PCHabitCellRadioButton: UIView {
    
    let radioContentView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.widthAnchor.constraint(equalToConstant: 30).isActive  = true
        return view
    }()
    let radioViewOuterRing   = UIView()
    let radioViewInnerCircle = UIView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(radioContentView)
        radioContentView.addSubview(radioViewOuterRing)
        radioContentView.addSubview(radioViewInnerCircle)
        
        // Configuring UI
//        configureRadioContentView()
        configureRadioViewOuterRing()
        configureRadioViewInnerCircle()
        
        // Setting all constraints
        setRadioContentViewConstraints()
        setRadioViewOuterRingConstraints()
        setRadioViewInnerCircleConstraints()
    }
    
    
    //MARK: Configuring button
    private func configureRadioContentView() {
        // Delete if empty
        
    }
    
    func configureRadioViewOuterRing() {
        radioViewOuterRing.layer.cornerRadius = 11
        radioViewOuterRing.layer.borderWidth = 3.5
        
        radioViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
        radioViewOuterRing.backgroundColor = .clear
        
    }
    
    func configureRadioViewInnerCircle() {
        radioViewInnerCircle.layer.cornerRadius = 5
        radioViewInnerCircle.backgroundColor = .clear
    }
    
    func radioSelected() {
        print("Radio button checked")
        radioViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
        radioViewInnerCircle.backgroundColor = .systemBlue
        radioViewOuterRing.tintColor = .white
    }
    
    func radioDeselected() {
        print("Radio button unchecked")
        radioViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
        radioViewOuterRing.backgroundColor = .clear
        radioViewInnerCircle.backgroundColor = .clear
    }
    
    // MARK: Setting button constraints
    func setRadioContentViewConstraints() {
        radioContentView.translatesAutoresizingMaskIntoConstraints                      = false
        radioContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        radioContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        radioContentView.heightAnchor.constraint(equalToConstant: 30).isActive          = true
        radioContentView.widthAnchor.constraint(equalToConstant: 30).isActive           = true
    }
    
    func setRadioViewOuterRingConstraints() {
        radioViewOuterRing.translatesAutoresizingMaskIntoConstraints                                  = false
        radioViewOuterRing.centerXAnchor.constraint(equalTo: radioContentView.centerXAnchor).isActive = true
        radioViewOuterRing.centerYAnchor.constraint(equalTo: radioContentView.centerYAnchor).isActive = true
        radioViewOuterRing.heightAnchor.constraint(equalToConstant: 22).isActive                      = true
        radioViewOuterRing.widthAnchor.constraint(equalToConstant: 22).isActive                       = true
    }
    
    func setRadioViewInnerCircleConstraints() {
        radioViewInnerCircle.translatesAutoresizingMaskIntoConstraints                                    = false
        radioViewInnerCircle.centerXAnchor.constraint(equalTo: radioViewOuterRing.centerXAnchor).isActive = true
        radioViewInnerCircle.centerYAnchor.constraint(equalTo: radioViewOuterRing.centerYAnchor).isActive = true
        radioViewInnerCircle.heightAnchor.constraint(equalToConstant: 10).isActive                        = true
        radioViewInnerCircle.widthAnchor.constraint(equalToConstant: 10).isActive                         = true
    }

    
}
