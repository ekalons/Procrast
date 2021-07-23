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
    let radioViewOuterRing   = UIView()
    let radioViewInnerCircle = UIView()
    var radioViewAction      : (() -> ())?

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(habitCardView)
        habitCardView.addSubview(radioView)
        radioView.addSubview(radioViewOuterRing)
        radioViewOuterRing.addSubview(radioViewInnerCircle)
        habitCardView.addSubview(habitTitleLabel)
        backgroundColor = .systemGray6
        
        // Configuring all UI
        configureHabitCardView()
        configureRadioView()
        configureRadioViewOuterRing()
        configureRadioViewInnerCircle()
        configureTitleLabel()
        
        // Setting all constraints
        setCardViewConstraints()
        setRadioViewConstraints()
        setRadioViewOuterRingConstraints()
        setRadioViewInnerCircleConstraints()
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
//        self.radioViewOuterRing.addTarget(self, action: #selector(onRadioButtonTap(_:)), for: .touchUpInside)
//
//    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureRadioViewOuterRing() {
        radioViewOuterRing.isUserInteractionEnabled = true
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onRadioViewTap(_:)))
        radioViewOuterRing.addGestureRecognizer(tapRecognizer)
        
        radioViewOuterRing.layer.cornerRadius = 11
        radioViewOuterRing.layer.borderWidth = 3.5
        
        radioViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
        radioViewOuterRing.backgroundColor = .clear
    }
    
    func configureRadioViewInnerCircle() {
        radioViewInnerCircle.layer.cornerRadius = 5
        radioViewInnerCircle.backgroundColor = .clear
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
    

    
    func setRadioViewOuterRingConstraints() {
        radioViewOuterRing.translatesAutoresizingMaskIntoConstraints                            = false
        radioViewOuterRing.centerXAnchor.constraint(equalTo: radioView.centerXAnchor).isActive  = true
        radioViewOuterRing.centerYAnchor.constraint(equalTo: radioView.centerYAnchor).isActive  = true
        radioViewOuterRing.heightAnchor.constraint(equalToConstant: 22).isActive                = true
        radioViewOuterRing.widthAnchor.constraint(equalToConstant: 22).isActive                 = true
    }
    
    func setRadioViewInnerCircleConstraints() {
        radioViewInnerCircle.translatesAutoresizingMaskIntoConstraints                                         = false
        radioViewInnerCircle.centerXAnchor.constraint(equalTo: radioViewOuterRing.centerXAnchor).isActive = true
        radioViewInnerCircle.centerYAnchor.constraint(equalTo: radioViewOuterRing.centerYAnchor).isActive = true
        radioViewInnerCircle.heightAnchor.constraint(equalToConstant: 10).isActive                             = true
        radioViewInnerCircle.widthAnchor.constraint(equalToConstant: 10).isActive                              = true
    }
    
    
    func setTitleLabelConstraints() {
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints                                          = false
        habitTitleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive                          = true
        habitTitleLabel.leadingAnchor.constraint(equalTo: radioView.trailingAnchor, constant: 8).isActive  = true
        habitTitleLabel.heightAnchor.constraint(equalToConstant: 40).isActive                              = true
        habitTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive         = true
    }
    
    
    @objc func onRadioViewTap(_ sender: UIView) {
        
        self.isSelected = !isSelected
        
        if isSelected {
            print("Radio button checked")
            radioViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
            radioViewInnerCircle.backgroundColor = .systemBlue
            radioViewOuterRing.tintColor = .white
        }
        else {
            print("Radio button unchecked")
            radioViewOuterRing.layer.borderColor = UIColor.systemBlue.cgColor
            radioViewOuterRing.backgroundColor = .clear
            radioViewInnerCircle.backgroundColor = .clear
        }
        
        radioViewAction?()
        
    }

}
