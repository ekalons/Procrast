//
//  HabitCell.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit

class HabitCell: UITableViewCell {
    
    var habitTitleLabel      = UILabel()
    let habitCardView        = UIView()
    var radioButton          = PCHabitCellRadioButton()
    var radioButtonAction      : (() -> ())?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(habitCardView)
        habitCardView.addSubview(radioButton)
        habitCardView.addSubview(habitTitleLabel)
        backgroundColor = .systemGray6
        
        // Configuring all UI
        configureHabitCardView()
        configureRadioButton()
        configureTitleLabel()
        
        // Setting all constraints
        setCardViewConstraints()
        setRadioButtonConstraints()
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
    
    func configureRadioButton() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onRadioViewTap(_:)))
        radioButton.addGestureRecognizer(tapRecognizer)
    }
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.radioViewOuterRing.addTarget(self, action: #selector(onRadioButtonTap(_:)), for: .touchUpInside)
//
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    func setRadioButtonConstraints() {
        radioButton.translatesAutoresizingMaskIntoConstraints                                             = false
        radioButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                             = true
        radioButton.heightAnchor.constraint(equalToConstant: 30).isActive                                 = true
        radioButton.leadingAnchor.constraint(equalTo: habitCardView.leadingAnchor, constant: 13).isActive = true
        radioButton.widthAnchor.constraint(equalToConstant: 30).isActive                                  = true
    }
    
    func setTitleLabelConstraints() {
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints                                           = false
        habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                           = true
        habitTitleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 8).isActive = true
        habitTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive                               = true
        habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive          = true
    }
    
    
    @objc func onRadioViewTap(_ sender: PCHabitCellRadioButton) {
        
        self.isSelected = !isSelected
        
        if isSelected {
            radioButton.radioSelected()
        }
        else {
            radioButton.radioDeselected()
        }
        
        radioButtonAction?()
        
    }

}
