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
        
        // Configuring UI & setting constraints
        configureHabitCardView()
        configureRadioButton()
        configureTitleLabel()
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(habit: Habit) {
        //Check minute 24
        habitTitleLabel.text = habit.title
    }
    
    func configureHabitCardView() {
        habitCardView.translatesAutoresizingMaskIntoConstraints = false
        habitCardView.layer.cornerRadius = 17
        habitCardView.backgroundColor    = UIColor.systemGray5
        
        NSLayoutConstraint.activate([
            habitCardView.centerXAnchor.constraint(equalTo: centerXAnchor),
            habitCardView.centerYAnchor.constraint(equalTo: centerYAnchor),
            habitCardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            habitCardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            habitCardView.heightAnchor.constraint(equalToConstant: 60)
        
        ])
    }
    
    func configureRadioButton() {
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onRadioViewTap(_:)))
        radioButton.addGestureRecognizer(tapRecognizer)
        
        NSLayoutConstraint.activate([
            radioButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            radioButton.heightAnchor.constraint(equalToConstant: 30),
            radioButton.leadingAnchor.constraint(equalTo: habitCardView.leadingAnchor, constant: 13),
            radioButton.widthAnchor.constraint(equalToConstant: 30)
        
        ])
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
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        habitTitleLabel.numberOfLines               = 0
        habitTitleLabel.adjustsFontSizeToFitWidth   = true
        habitTitleLabel.font                        = UIFont.systemFont(ofSize: 18, weight: .semibold)
        habitTitleLabel.textColor                   = .white
        
        NSLayoutConstraint.activate([
            habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            habitTitleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 8),
            habitTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        
        ])
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
