//
//  PCHabitCellRadioButton.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz Alonso on 7/23/21.
//

import UIKit
import RealmSwift

class PCHabitCellRadioButton: UIView {
    
    var userPickedUIColor: UIColor? = nil
    
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
        
        // Configuring UI & setting constraints
        configureRadioContentView()
        configureRadioViewOuterRing()
        configureRadioViewInnerCircle()

    }
    
    
    //MARK: Configuring button
    private func configureRadioContentView() {
        radioContentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            radioContentView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            radioContentView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            radioContentView.heightAnchor.constraint(equalToConstant: 30),
            radioContentView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    // This is color is called from the HabitCell
    func configureRadioViewOuterRingColor(userColorInHex: String) {
        userPickedUIColor = UIColor(hexaString: userColorInHex)
        radioViewOuterRing.layer.borderColor = userPickedUIColor?.cgColor
        print(String(describing: userColorInHex))
    }
    
    func configureRadioViewOuterRing() {
        radioViewOuterRing.translatesAutoresizingMaskIntoConstraints = false
        radioViewOuterRing.layer.cornerRadius = 11
        radioViewOuterRing.layer.borderWidth = 3.5
        radioViewOuterRing.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            radioViewOuterRing.centerXAnchor.constraint(equalTo: radioContentView.centerXAnchor),
            radioViewOuterRing.centerYAnchor.constraint(equalTo: radioContentView.centerYAnchor),
            radioViewOuterRing.heightAnchor.constraint(equalToConstant: 22),
            radioViewOuterRing.widthAnchor.constraint(equalToConstant: 22)
        ])
        
    }
    
    func configureRadioViewInnerCircle() {
        radioViewInnerCircle.translatesAutoresizingMaskIntoConstraints = false
        radioViewInnerCircle.layer.cornerRadius = 5
        radioViewInnerCircle.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            radioViewInnerCircle.centerXAnchor.constraint(equalTo: radioViewOuterRing.centerXAnchor),
            radioViewInnerCircle.centerYAnchor.constraint(equalTo: radioViewOuterRing.centerYAnchor),
            radioViewInnerCircle.heightAnchor.constraint(equalToConstant: 10),
            radioViewInnerCircle.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    // MARK: Radio button selection states
    func radioSelected(userColorInHex: String) {
        userPickedUIColor = UIColor(hexaString: userColorInHex)
        print("Radio button checked")
        radioViewOuterRing.layer.borderColor = userPickedUIColor?.cgColor
        radioViewInnerCircle.backgroundColor = userPickedUIColor
//        radioViewOuterRing.tintColor = .white
    }
    
    func radioDeselected(userColorInHex: String) {
        userPickedUIColor = UIColor(hexaString: userColorInHex)
        print("Radio button unchecked")
        radioViewOuterRing.layer.borderColor = userPickedUIColor?.cgColor
        radioViewOuterRing.backgroundColor = .clear
        radioViewInnerCircle.backgroundColor = .clear
    }

    
}
