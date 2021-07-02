//
//  HabitCell.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit

class HabitCell: UITableViewCell {
    
    let completedHabitCheckBox  = CircularCheckBox()
    var habitTitleLabel = UILabel()
    let habitCardView   = UIView()

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(habitCardView)
        addSubview(completedHabitCheckBox)
        addSubview(habitTitleLabel)
        backgroundColor = .systemGray6
        
        configureHabitCardView()
        configureCompletedHabitButton()
        configureTitleLabel()
        setCardViewConstraints()
        setCompletedHabitCheckBoxContraints()
        setTitleLabelConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(habit: Habit) {
        //Check minute 24
        completedHabitCheckBox.backgroundColor = .systemYellow
        habitTitleLabel.text = habit.title
    }
    
    func configureHabitCardView() {
        habitCardView.layer.cornerRadius = 17
        habitCardView.backgroundColor    = UIColor.systemGray5
    }
    
    func configureCompletedHabitButton() {
        completedHabitCheckBox.clipsToBounds = true
        
        completedHabitCheckBox.layer.cornerRadius = 15
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))
        completedHabitCheckBox.addGestureRecognizer(gesture)
        
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
    
    func setCompletedHabitCheckBoxContraints() {
        completedHabitCheckBox.translatesAutoresizingMaskIntoConstraints                                              = false
        completedHabitCheckBox.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                              = true
        completedHabitCheckBox.leadingAnchor.constraint(equalTo: habitCardView.leadingAnchor, constant: 15).isActive  = true
        completedHabitCheckBox.heightAnchor.constraint(equalToConstant: 30).isActive                                  = true
        completedHabitCheckBox.widthAnchor.constraint(equalToConstant: 30).isActive                                   = true
    }
    
    func setTitleLabelConstraints() {
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints                                                       = false
        habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                                       = true
        habitTitleLabel.leadingAnchor.constraint(equalTo: completedHabitCheckBox.trailingAnchor, constant: 10).isActive   = true
        habitTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive                                           = true
        habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive                      = true
    }
    
    
    @objc func didTapCheckBox() {
        completedHabitCheckBox.toggle()
    }

}
