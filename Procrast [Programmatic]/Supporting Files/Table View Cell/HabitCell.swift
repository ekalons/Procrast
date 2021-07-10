//
//  HabitCell.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit

class HabitCell: UITableViewCell {
    
    var habitTitleLabel = UILabel()
    let habitCardView   = UIView()
    let radioView       = UIView()
    let radioButton     = UIButton()
    let radioImage      = UIImageView()
    

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(habitCardView)
        addSubview(radioView)
        addSubview(habitTitleLabel)
        backgroundColor = .systemGray6
        
        // Configuring all UI
        configureHabitCardView()
        configureRadioView()
        configureRadioButton()
        configureRadioImageView()
        configureTitleLabel()
        
        // Setting all constraints
        setCardViewConstraints()
        setRadioViewConstraints()
        setRadioButtonConstraints()
        setRadioImageViewConstraints()
        setTitleLabelConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(habit: Habit) {
        //Check minute 24
        habitTitleLabel.text = habit.title
    }
    
    func configureHabitCardView() {
        habitCardView.layer.cornerRadius = 17
        habitCardView.backgroundColor    = UIColor.systemGray5
    }
    
    func configureRadioView() {
        //Remove function if empty
    }
    
    func configureRadioButton() {
        radioView.addSubview(radioButton)
        radioButton.tag = tag
        radioButton.addTarget(self, action: #selector(onRadioTapButton), for: .touchUpInside)
    }
    
    func configureRadioImageView() {
        radioView.addSubview(radioImage)
        radioImage.layer.cornerRadius = 11
        radioImage.layer.borderWidth = 3.5
        
        if isSelected {
            print("Button checked")
            radioImage.layer.borderColor = UIColor.systemBlue.cgColor
            radioImage.backgroundColor = .systemBlue
            radioImage.tintColor = .white
        } else {
            radioImage.layer.borderColor = UIColor.systemBlue.cgColor
            radioImage.backgroundColor = .clear
            radioImage.image = nil
        }
    }
    
    
    func configureTitleLabel() {
        habitTitleLabel.numberOfLines               = 0
        habitTitleLabel.adjustsFontSizeToFitWidth   = true
        habitTitleLabel.font                        = UIFont.systemFont(ofSize: 18, weight: .semibold)
        habitTitleLabel.textColor                   = .white
        
        
        
    }
    
    // MARK: Setting the constraints
    
    func setCardViewConstraints() {
        habitCardView.translatesAutoresizingMaskIntoConstraints                                     = false
        habitCardView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                     = true
        habitCardView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive                     = true
        habitCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive       = true
        habitCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive    = true
        habitCardView.heightAnchor.constraint(equalToConstant: 60).isActive                         = true
        
    }
    
    func setRadioViewConstraints() {
        radioView.translatesAutoresizingMaskIntoConstraints                                             = false
        radioView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                             = true
        radioView.heightAnchor.constraint(equalToConstant: 30).isActive                                 = true
        radioView.leadingAnchor.constraint(equalTo: habitCardView.leadingAnchor, constant: 18).isActive = true
        radioView.widthAnchor.constraint(equalToConstant: 30).isActive                                  = true
    }
    
    func setRadioButtonConstraints() {
        radioButton.translatesAutoresizingMaskIntoConstraints                           = false
        radioButton.topAnchor.constraint(equalTo: radioView.topAnchor).isActive         = true
        radioButton.bottomAnchor.constraint(equalTo: radioView.bottomAnchor).isActive   = true
        radioButton.leftAnchor.constraint(equalTo: radioView.leftAnchor).isActive       = true
        radioButton.rightAnchor.constraint(equalTo: radioView.rightAnchor).isActive     = true
    }
    
    func setRadioImageViewConstraints() {
        radioImage.translatesAutoresizingMaskIntoConstraints                            = false
        radioImage.centerYAnchor.constraint(equalTo: radioView.centerYAnchor).isActive  = true
        radioImage.leftAnchor.constraint(equalTo: radioImage.leftAnchor).isActive       = true
        radioImage.heightAnchor.constraint(equalToConstant: 22).isActive                = true
        radioImage.widthAnchor.constraint(equalToConstant: 22).isActive                 = true
    }
    
    
    func setTitleLabelConstraints() {
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints                                          = false
        habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                          = true
        habitTitleLabel.leadingAnchor.constraint(equalTo: radioView.trailingAnchor, constant: 10).isActive = true
        habitTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
        habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive         = true
    }
    
    
    @objc func onRadioTapButton(sender: UIButton) {
//        radioView.toggle()
        
    }

}
