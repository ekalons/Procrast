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
    let radioView            = UIView()
    let radioImageView       = UIImageView()
    var radioImageViewAction : (() -> ())?

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(habitCardView)
        habitCardView.addSubview(radioView)
        radioView.addSubview(radioImageView)
        habitCardView.addSubview(habitTitleLabel)
        backgroundColor = .systemGray6
        
        // Configuring all UI
        configureHabitCardView()
        configureRadioView()
        configureRadioImageView()
        configureTitleLabel()
        
        // Setting all constraints
        setCardViewConstraints()
        setRadioViewConstraints()
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
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.radioImageView.addTarget(self, action: #selector(onRadioButtonTap(_:)), for: .touchUpInside)
//
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureRadioImageView() {
//        radioView.addSubview(radioImage)
        radioImageView.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onRadioImageViewTap(_:)))
        radioImageView.addGestureRecognizer(tapRecognizer)
        
        radioImageView.layer.cornerRadius = 11
        radioImageView.layer.borderWidth = 3.5
        
        if isSelected {
            print("Button checked")
            radioImageView.layer.borderColor = UIColor.systemBlue.cgColor
            radioImageView.backgroundColor = .systemBlue
            radioImageView.tintColor = .white
        } else {
            radioImageView.layer.borderColor = UIColor.systemBlue.cgColor
            radioImageView.backgroundColor = .clear
            radioImageView.image = nil
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
    

    
    func setRadioImageViewConstraints() {
        radioImageView.translatesAutoresizingMaskIntoConstraints                            = false
        radioImageView.centerYAnchor.constraint(equalTo: radioView.centerYAnchor).isActive  = true
        radioImageView.leftAnchor.constraint(equalTo: radioView.leftAnchor).isActive       = true
        radioImageView.heightAnchor.constraint(equalToConstant: 22).isActive                = true
        radioImageView.widthAnchor.constraint(equalToConstant: 22).isActive                 = true
    }
    
    
    func setTitleLabelConstraints() {
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints                                          = false
        habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                          = true
        habitTitleLabel.leadingAnchor.constraint(equalTo: radioView.trailingAnchor, constant: 10).isActive = true
        habitTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
        habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive         = true
    }
    
    
    @objc func onRadioImageViewTap(_ sender: UIImageView) {
        
        radioImageViewAction?()
//        radioView.toggle()
        
    }

}
