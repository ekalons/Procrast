//
//  CreateHabitViewController.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/18/21.
//

import UIKit

class CreateHabitViewController: UIViewController {
    
    let addHabitButton      = PCIconButton()
    let leavePageButton     = PCIconButton()
    
    let habitNameCard       = UIView()
    let habitNameLabel      = UITextField()
    
    let habitDetailsCard    = UIView()
    let pickColorLabel      = UILabel()
    
    let stackView           = UIStackView()
    
    let Color1Button        = PCRoundColorButton()
    let Color2Button        = PCRoundColorButton()
    let Color3Button        = PCRoundColorButton()
    let Color4Button        = PCRoundColorButton()
    let Color5Button        = PCRoundColorButton()
    let Color6Button        = PCRoundColorButton()
    let Color7Button        = PCRoundColorButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    func configureUI() {
        view.backgroundColor = .systemGray6
        
        configureHabitNameCardView()
        configureAddHabitButton()
        configureLeavePageButton()
        configureHabitNameLabel()
        configureHabitDetailsCardView()
        configurePickColorLabel()
        
        //7 Color buttons and the StackView holding them
        configureColorButtons()
        configureStackView()
        
        //Calls every constraint
        setAllConstraints()
        
    }
    
    
// MARK: Configuring views & buttons
    func configureHabitNameCardView() {
        view.addSubview(habitNameCard)
        habitNameCard.backgroundColor = UIColor.systemBlue
    }
    
    func configureHabitNameLabel() {
        view.addSubview(habitNameLabel)
        habitNameLabel.placeholder = "Add a habit name here!"
        habitNameLabel.textColor = UIColor.white
        
    }
    
    func configureHabitDetailsCardView() {
        view.addSubview(habitDetailsCard)
        habitDetailsCard.layer.cornerRadius = 10
        habitDetailsCard.backgroundColor = .systemGray5
    }
    
    func configurePickColorLabel() {
        view.addSubview(pickColorLabel)
        pickColorLabel.text = "Pick a color"
        pickColorLabel.textColor = UIColor.lightGray
        pickColorLabel.font = UIFont.systemFont(ofSize: 19, weight: .heavy)
        
    }
    
    func configureStackView() {
        let colorButtonsArray = [Color1Button, Color2Button, Color3Button, Color4Button, Color5Button, Color6Button, Color7Button]
        
        view.addSubview(stackView)
        stackView.axis              = .horizontal
        stackView.distribution      = .equalSpacing
        
        for button in colorButtonsArray {
            
            button.widthAnchor.constraint(equalToConstant: 37).isActive = true
            
            stackView.addArrangedSubview(button)
        }
        
        setStackViewConstraints()

    }

    
    func configureColorButtons() {

        //Red
        func configureColor1Button() {
            view.addSubview(Color1Button)
            Color1Button.backgroundColor = .systemRed
        }
        //Blue
        func configureColor2Button() {
            view.addSubview(Color2Button)
            Color2Button.backgroundColor = .systemOrange
        }
        func configureColor3Button() {
            view.addSubview(Color3Button)
            Color3Button.backgroundColor = .systemYellow
        }
        func configureColor4Button() {
            view.addSubview(Color4Button)
            Color4Button.backgroundColor = .green
        }
        func configureColor5Button() {
            view.addSubview(Color5Button)
            Color5Button.backgroundColor = .systemGreen
        }
        func configureColor6Button() {
            view.addSubview(Color6Button)
            Color6Button.backgroundColor = .systemBlue
        }
        
        func configureColor7Button() {
            view.addSubview(Color7Button)
            Color7Button.backgroundColor = .blue
        }
        
        
        
        
        
        //Calling all color buttons
        configureColor1Button()
        configureColor2Button()
        configureColor3Button()
        configureColor4Button()
        configureColor5Button()
        configureColor6Button()
        configureColor7Button()

    }
    
    
        
    
//  Configuring navigation buttons on top of screen
    func configureAddHabitButton() {
        view.addSubview(addHabitButton)
        addHabitButton.setImage(Icons.smallPlusIcon, for: .normal)
        addHabitButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
        //Add target & obj function --> Look up how to pass data between screens

    }
    
    func configureLeavePageButton() {
        view.addSubview(leavePageButton)
        leavePageButton.setImage(Icons.chevronIcon, for: .normal)
        leavePageButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
  
    }
    
    
// MARK: Setting up constraints
    
    func setAllConstraints() {
        
        setHabitNameCardViewConstraints()
        setHabitDetailsCardViewConstraints()
        setAddHabitButtonConstraints()
        setLeavePageButtonConstraints()
        setPickColorLabelConstraints()
        setStackViewConstraints()
        setHabitNameLabelConstraints()

    }
    
    
    //All the individual constraints
    func setHabitNameCardViewConstraints() {
        habitNameCard.translatesAutoresizingMaskIntoConstraints                     = false
        habitNameCard.heightAnchor.constraint(equalToConstant: 100).isActive        = true
        habitNameCard.widthAnchor.constraint(equalTo: view.widthAnchor).isActive    = true
        habitNameCard.topAnchor.constraint(equalTo: view.topAnchor).isActive        = true
        
    }
    
    func setHabitDetailsCardViewConstraints() {
        habitDetailsCard.translatesAutoresizingMaskIntoConstraints                                          = false
        habitDetailsCard.heightAnchor.constraint(equalToConstant: 250).isActive                             = true
        habitDetailsCard.topAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: 15).isActive   = true
        habitDetailsCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive             = true
        habitDetailsCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive          = true
    }
    
    func setAddHabitButtonConstraints() {
        addHabitButton.translatesAutoresizingMaskIntoConstraints                                    = false
        addHabitButton.heightAnchor.constraint(equalToConstant: 30).isActive                        = true
        addHabitButton.widthAnchor.constraint(equalToConstant: 31).isActive                         = true
        addHabitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive    = true
        addHabitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive         = true
    }
    
    func setLeavePageButtonConstraints() {
        leavePageButton.translatesAutoresizingMaskIntoConstraints                               = false
        leavePageButton.heightAnchor.constraint(equalToConstant: 30).isActive                   = true
        leavePageButton.widthAnchor.constraint(equalToConstant: 31).isActive                    = true
        leavePageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19).isActive  = true
        leavePageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive    = true
    }
    
    func setHabitNameLabelConstraints() {
        habitNameLabel.translatesAutoresizingMaskIntoConstraints                                            = false
        habitNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive                                = true
        habitNameLabel.bottomAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: -5).isActive  = true
        habitNameLabel.leftAnchor.constraint(equalTo: pickColorLabel.leftAnchor).isActive                   = true
        habitNameLabel.rightAnchor.constraint(equalTo: pickColorLabel.rightAnchor).isActive                 = true
    }
    
    func setPickColorLabelConstraints() {
        pickColorLabel.translatesAutoresizingMaskIntoConstraints                                                = false
        pickColorLabel.heightAnchor.constraint(equalToConstant: 30).isActive                                    = true
        pickColorLabel.topAnchor.constraint(equalTo: habitDetailsCard.topAnchor, constant: 15).isActive         = true
        pickColorLabel.leftAnchor.constraint(equalTo: habitDetailsCard.leftAnchor, constant: 20).isActive       = true
        pickColorLabel.rightAnchor.constraint(equalTo: habitDetailsCard.rightAnchor, constant: -20).isActive    = true
        
    }
    
    func setStackViewConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints                                                     = false
        stackView.topAnchor.constraint(equalTo: pickColorLabel.bottomAnchor, constant: 18).isActive             = true
        stackView.leadingAnchor.constraint(equalTo: habitDetailsCard.leadingAnchor, constant: 13).isActive      = true
        stackView.trailingAnchor.constraint(equalTo: habitDetailsCard.trailingAnchor, constant: -13).isActive   = true
        stackView.heightAnchor.constraint(equalToConstant: 38).isActive                                         = true
    }
    
    
    
    //Might have to make 2 versions of backToMainVC, 1 that passes data and 1 that doesn't
    @objc func backToMainVC() {
        dismiss(animated: true)
        
    }
    
    
    
    

}
