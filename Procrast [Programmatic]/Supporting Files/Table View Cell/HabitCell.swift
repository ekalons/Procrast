//
//  HabitCell.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/19/21.
//

import UIKit

class HabitCell: UITableViewCell {
    
    var habitTitleLabel             = UILabel()
    let habitCardView               = UIView()
    let radioView                   = UIView()
    let radioImageViewOuterRing     = UIImageView()
    let radioImageViewInnerCircle   = UIImageView()
    var radioImageViewAction        : (() -> ())?

    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(habitCardView)
        habitCardView.addSubview(radioView)
        radioView.addSubview(radioImageViewOuterRing)
        radioImageViewOuterRing.addSubview(radioImageViewInnerCircle)
        habitCardView.addSubview(habitTitleLabel)
        backgroundColor = .systemGray6
        
        // Configuring all UI
        configureHabitCardView()
        configureRadioView()
        configureRadioImageViewOuterRing()
        configureRadioImageViewInnerCircle()
        configureTitleLabel()
        
        // Setting all constraints
        setCardViewConstraints()
        setRadioViewConstraints()
        setRadioImageViewOuterRingConstraints()
        setRadioImageViewInnerCircleConstraints()
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
//        radioView.backgroundColor = .systemRed
        
        //Remove function if empty
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        self.radioImageViewOuterRing.addTarget(self, action: #selector(onRadioButtonTap(_:)), for: .touchUpInside)
//
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureRadioImageViewOuterRing() {
        radioImageViewOuterRing.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onRadioImageViewTap(_:)))
        radioImageViewOuterRing.addGestureRecognizer(tapRecognizer)
        
        radioImageViewOuterRing.layer.cornerRadius = 11
        radioImageViewOuterRing.layer.borderWidth = 3.5
        
        radioImageViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
        radioImageViewOuterRing.backgroundColor = .clear
//        radioImageViewOuterRing.image = nil
    }
    
    func configureRadioImageViewInnerCircle() {
        radioImageViewInnerCircle.layer.cornerRadius = 5
        radioImageViewInnerCircle.backgroundColor = .clear
        radioImageViewInnerCircle.image = nil
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
        radioView.leadingAnchor.constraint(equalTo: habitCardView.leadingAnchor, constant: 13).isActive = true
        radioView.widthAnchor.constraint(equalToConstant: 30).isActive                                  = true
    }
    

    
    func setRadioImageViewOuterRingConstraints() {
        radioImageViewOuterRing.translatesAutoresizingMaskIntoConstraints                            = false
        radioImageViewOuterRing.centerXAnchor.constraint(equalTo: radioView.centerXAnchor).isActive  = true
        radioImageViewOuterRing.centerYAnchor.constraint(equalTo: radioView.centerYAnchor).isActive  = true
        radioImageViewOuterRing.heightAnchor.constraint(equalToConstant: 22).isActive                = true
        radioImageViewOuterRing.widthAnchor.constraint(equalToConstant: 22).isActive                 = true
    }
    
    func setRadioImageViewInnerCircleConstraints() {
        radioImageViewInnerCircle.translatesAutoresizingMaskIntoConstraints                                         = false
        radioImageViewInnerCircle.centerXAnchor.constraint(equalTo: radioImageViewOuterRing.centerXAnchor).isActive = true
        radioImageViewInnerCircle.centerYAnchor.constraint(equalTo: radioImageViewOuterRing.centerYAnchor).isActive = true
        radioImageViewInnerCircle.heightAnchor.constraint(equalToConstant: 10).isActive                             = true
        radioImageViewInnerCircle.widthAnchor.constraint(equalToConstant: 10).isActive                              = true
    }
    
    
    func setTitleLabelConstraints() {
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints                                          = false
        habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                          = true
        habitTitleLabel.leadingAnchor.constraint(equalTo: radioView.trailingAnchor, constant: 8).isActive  = true
        habitTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
        habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive         = true
    }
    
    
    @objc func onRadioImageViewTap(_ sender: UIImageView) {
        
        self.isSelected = !isSelected
        
        if isSelected {
            print("Radio button checked")
            radioImageViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
//            radioImageViewOuterRing.backgroundColor = .systemBlue
//            radioImageViewOuterRing.image = UIImage(systemName: "circlebadge")
            radioImageViewInnerCircle.backgroundColor = .systemBlue
            radioImageViewOuterRing.tintColor = .white
        }
        else {
            print("Radio button unchecked")
            radioImageViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
            radioImageViewOuterRing.backgroundColor = .clear
            radioImageViewOuterRing.image = nil
            radioImageViewInnerCircle.backgroundColor = .clear
        }
        
        radioImageViewAction?()
        
    }

}
