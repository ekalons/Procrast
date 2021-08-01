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
    
    let colorPicker = PCRoundColorButton()
    var colorPickerAction : (() -> ())?
    
    let stackView           = UIStackView()

    let color1Button = PCRoundColorButton(),
        color2Button = PCRoundColorButton(),
        color3Button = PCRoundColorButton(),
        color4Button = PCRoundColorButton(),
        color5Button = PCRoundColorButton(),
        color6Button = PCRoundColorButton(),
        color7Button = PCRoundColorButton()
    
    var selectionState: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    func configureUI() {
        view.backgroundColor = .systemGray6
        
        
        
        configureColorButtons()
        configureHabitNameCardView()
        configureHabitDetailsCardView()
        configureAddHabitButton()
        configureLeavePageButton()
        configurePickColorLabel()
        
        configureStackView()
        configureHabitNameLabel()
        
    }
    
    
// MARK: Configuring views, buttons & constraints
    func configureHabitNameCardView() {
        habitNameCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(habitNameCard)
        habitNameCard.backgroundColor = UIColor.systemBlue
        
        NSLayoutConstraint.activate([
            habitNameCard.heightAnchor.constraint(equalToConstant: 100),
            habitNameCard.widthAnchor.constraint(equalTo: view.widthAnchor),
            habitNameCard.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    func configureHabitNameLabel() {
        habitNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(habitNameLabel)
        habitNameLabel.placeholder = "Add a habit name here!"
        habitNameLabel.textColor = UIColor.white
        
        NSLayoutConstraint.activate([
            habitNameLabel.heightAnchor.constraint(equalToConstant: 30),
            habitNameLabel.bottomAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: -5),
            habitNameLabel.leftAnchor.constraint(equalTo: pickColorLabel.leftAnchor),
            habitNameLabel.rightAnchor.constraint(equalTo: pickColorLabel.rightAnchor),
        ])
        
    }
    
    func configureHabitDetailsCardView() {
        habitDetailsCard.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(habitDetailsCard)
        habitDetailsCard.layer.cornerRadius = 10
        habitDetailsCard.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            habitDetailsCard.heightAnchor.constraint(equalToConstant: 250),
            habitDetailsCard.topAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: 15),
            habitDetailsCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            habitDetailsCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        ])
    }
    
    func configurePickColorLabel() {
        pickColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pickColorLabel)
        pickColorLabel.text = "Pick a color"
        pickColorLabel.textColor = UIColor.lightGray
        pickColorLabel.font = UIFont.systemFont(ofSize: 19, weight: .heavy)
        
        NSLayoutConstraint.activate([
            pickColorLabel.heightAnchor.constraint(equalToConstant: 30),
            pickColorLabel.topAnchor.constraint(equalTo: habitDetailsCard.topAnchor, constant: 15),
            pickColorLabel.leftAnchor.constraint(equalTo: habitDetailsCard.leftAnchor, constant: 20),
            pickColorLabel.rightAnchor.constraint(equalTo: habitDetailsCard.rightAnchor, constant: -20)
        ])
        
    }
    
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let colorButtonsArray = [color1Button, color2Button, color3Button, color4Button, color5Button, color6Button, color7Button]
        
        view.addSubview(stackView)
        stackView.axis              = .horizontal
        stackView.distribution      = .equalSpacing
        
        for button in colorButtonsArray {
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onColorButtonTap(_:)))
            button.addGestureRecognizer(tapRecognizer)
            
            button.widthAnchor.constraint(equalToConstant: 37).isActive = true
            stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 38),
            stackView.topAnchor.constraint(equalTo: pickColorLabel.bottomAnchor, constant: 18),
            stackView.leadingAnchor.constraint(equalTo: habitDetailsCard.leadingAnchor, constant: 13),
            stackView.trailingAnchor.constraint(equalTo: habitDetailsCard.trailingAnchor, constant: -13)
        ])

    }

    
    func configureColorButtons() {
        
        view.addSubview(color1Button)
        view.addSubview(color2Button)
        view.addSubview(color3Button)
        view.addSubview(color4Button)
        view.addSubview(color5Button)
        view.addSubview(color6Button)
        view.addSubview(color7Button)
        
        
        //Setting all colors
        color1Button.colorButtonContentView.backgroundColor = UIColor.systemRed
        color2Button.colorButtonContentView.backgroundColor = UIColor.systemOrange
        color3Button.colorButtonContentView.backgroundColor = UIColor.systemYellow
        color4Button.colorButtonContentView.backgroundColor = UIColor.green
        color5Button.colorButtonContentView.backgroundColor = UIColor.systemGreen
        color6Button.colorButtonContentView.backgroundColor = UIColor.systemBlue
        color7Button.colorButtonContentView.backgroundColor = UIColor.blue
        
    }
    
    
        
    
//  Configuring navigation buttons on top of screen
    func configureAddHabitButton() {
        addHabitButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addHabitButton)
        addHabitButton.setImage(Icons.smallPlusIcon, for: .normal)
        addHabitButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
        //Add target & obj function --> Look up how to pass data between screens
        
        NSLayoutConstraint.activate([
            addHabitButton.heightAnchor.constraint(equalToConstant: 30),
            addHabitButton.widthAnchor.constraint(equalToConstant: 31),
            addHabitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            addHabitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])

    }
    
    func configureLeavePageButton() {
        leavePageButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(leavePageButton)
        leavePageButton.setImage(Icons.chevronIcon, for: .normal)
        leavePageButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
  
        NSLayoutConstraint.activate([
            leavePageButton.heightAnchor.constraint(equalToConstant: 30),
            leavePageButton.widthAnchor.constraint(equalToConstant: 31),
            leavePageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19),
            leavePageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])
    }
    
    
    // Might have to make 2 versions of backToMainVC, 1 that passes data and 1 that doesn't
    @objc func backToMainVC() {
        dismiss(animated: true)
        
    }
    
    @objc func onColorButtonTap(_ sender: PCRoundColorButton) {
        
        self.selectionState = !selectionState
        
        if self.selectionState == true {
            print(sender)
            
            color1Button.colorSelected()
            colorPickerAction?()
        } else {
            color1Button.colorDeselected()
        }

    }
    
    
    

}
