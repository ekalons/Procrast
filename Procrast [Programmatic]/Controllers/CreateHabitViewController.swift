//
//  CreateHabitViewController.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/18/21.
//

import UIKit
import RealmSwift

protocol CreateHabitDelegate: AnyObject {
    func modalVCWillDismiss(_ modalVC: CreateHabitViewController)
}

class CreateHabitViewController: UIViewController {
    
    weak var delegate: CreateHabitDelegate?
    
    let realm = try! Realm()
    var habits: Results<Habit>!
    
    let addHabitButton      = PCIconButton()
    let leavePageButton     = PCIconButton()
    
    let habitNameCard        = UIView()
    let habitColorPickerCard = UIView()
    let avoidWeekendCard     = UIView()
    let avoidWeekendLabel    = UILabel()
    
    let remindersCard        = UIView()
    let remindersLabel       = UILabel()
    let remindersSwitch      = UISwitch()
    
    let habitNameLabel       = UITextField()
    let pickColorLabel       = UILabel()
    let avoidWeekendsSwitch  = UISwitch()
    
    let colorPicker = PCRoundColorButton()
    
    let stackView = UIStackView()

    let color1Button = PCRoundColorButton(),
        color2Button = PCRoundColorButton(),
        color3Button = PCRoundColorButton(),
        color4Button = PCRoundColorButton(),
        color5Button = PCRoundColorButton(),
        color6Button = PCRoundColorButton(),
        color7Button = PCRoundColorButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
// MARK: Realm DB function
    func save(habit: Habit) {
        do {
            try realm.write {
                realm.add(habit)
            }
        } catch {
            print("Error saving habit \(error)")
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemGray6
        
        
        
        // Navigation buttons
        configureHabitNameCardView()
        configureAddHabitButton()
        configureLeavePageButton()
        
        // Color picker buttons
        configureColorButtons()
        configureHabitColorPickerCardView()
        configurePickColorLabel()
        configureStackView()
        configureHabitNameLabel()
        
        // Avoid weekend switch
        configureAvoidWeekendsCard()
        configureAvoidWeekendSwitch()
        configureAvoidWeekendsLabel()
        
        // Reminder switch
        configureRemindersCard()
        configureRemindersSwitch()
        configureRemindersLabel()
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
//        habitNameLabel.placeholder = "Add a habit name here!"
        habitNameLabel.attributedPlaceholder = NSAttributedString(string: "Add a habit name here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        habitNameLabel.textColor = UIColor.white
        habitNameLabel.becomeFirstResponder()
        
        NSLayoutConstraint.activate([
            habitNameLabel.heightAnchor.constraint(equalToConstant: 30),
            habitNameLabel.bottomAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: -5),
            habitNameLabel.leftAnchor.constraint(equalTo: pickColorLabel.leftAnchor),
            habitNameLabel.rightAnchor.constraint(equalTo: pickColorLabel.rightAnchor),
        ])
        
    }
    
    func configureHabitColorPickerCardView() {
        habitColorPickerCard.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(habitColorPickerCard)
        habitColorPickerCard.layer.cornerRadius = 15
        habitColorPickerCard.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            habitColorPickerCard.heightAnchor.constraint(equalToConstant: 120),
            habitColorPickerCard.topAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: 12),
            habitColorPickerCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            habitColorPickerCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    func configureAvoidWeekendsCard() {
        avoidWeekendCard.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(avoidWeekendCard)
        
        avoidWeekendCard.layer.cornerRadius = 15
        avoidWeekendCard.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            avoidWeekendCard.heightAnchor.constraint(equalToConstant: 60),
            avoidWeekendCard.topAnchor.constraint(equalTo: habitColorPickerCard.bottomAnchor, constant: 12),
            avoidWeekendCard.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor),
            avoidWeekendCard.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor)
        ])
    }
    
    func configureAvoidWeekendsLabel() {
        avoidWeekendLabel.translatesAutoresizingMaskIntoConstraints = false

        avoidWeekendCard.addSubview(avoidWeekendLabel)

        avoidWeekendLabel.text = "Avoid weekends"
        avoidWeekendLabel.textColor = pickColorLabel.textColor
        avoidWeekendLabel.font = UIFont.systemFont(ofSize: 19)

        NSLayoutConstraint.activate([
            avoidWeekendLabel.heightAnchor.constraint(equalToConstant: 30),
            avoidWeekendLabel.leadingAnchor.constraint(equalTo: avoidWeekendCard.leadingAnchor, constant: 20),
            avoidWeekendLabel.trailingAnchor.constraint(equalTo: avoidWeekendsSwitch.leadingAnchor, constant: -20),
            avoidWeekendLabel.centerYAnchor.constraint(equalTo: avoidWeekendCard.centerYAnchor),
        ])
    }
    
    func configureAvoidWeekendSwitch() {
        avoidWeekendsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        avoidWeekendCard.addSubview(avoidWeekendsSwitch)
        avoidWeekendsSwitch.onTintColor = .systemBlue

        NSLayoutConstraint.activate([
            avoidWeekendsSwitch.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            avoidWeekendsSwitch.centerYAnchor.constraint(equalTo: avoidWeekendCard.centerYAnchor),
        ])
    }
    
    func configureRemindersCard() {
        remindersCard.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(remindersCard)
        
        remindersCard.layer.cornerRadius = 15
        remindersCard.backgroundColor = .systemGray5
        
        NSLayoutConstraint.activate([
            remindersCard.heightAnchor.constraint(equalToConstant: 60),
            remindersCard.topAnchor.constraint(equalTo: avoidWeekendCard.bottomAnchor, constant: 12),
            remindersCard.leadingAnchor.constraint(equalTo: avoidWeekendCard.leadingAnchor),
            remindersCard.trailingAnchor.constraint(equalTo: avoidWeekendCard.trailingAnchor),
            
        ])
        
    }
    
    func configureRemindersSwitch() {
        remindersSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        remindersCard.addSubview(remindersSwitch)
        remindersSwitch.onTintColor = .systemBlue
        
        NSLayoutConstraint.activate([
            remindersSwitch.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            remindersSwitch.centerYAnchor.constraint(equalTo: remindersCard.centerYAnchor)
        ])
        
    }
    
    func configureRemindersLabel() {
        remindersLabel.translatesAutoresizingMaskIntoConstraints = false
        
        remindersCard.addSubview(remindersLabel)
        
        remindersLabel.text = "Reminders"
        remindersLabel.textColor = pickColorLabel.textColor
        remindersLabel.font = avoidWeekendLabel.font
        
        NSLayoutConstraint.activate([
            remindersLabel.heightAnchor.constraint(equalToConstant: 30),
            remindersLabel.leadingAnchor.constraint(equalTo: remindersCard.leadingAnchor, constant: 20),
            remindersLabel.trailingAnchor.constraint(equalTo: remindersSwitch.leadingAnchor, constant: -20),
            remindersLabel.centerYAnchor.constraint(equalTo: remindersCard.centerYAnchor),
        ])
        
    }
    
    
    func configurePickColorLabel() {
        pickColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        habitColorPickerCard.addSubview(pickColorLabel)
        pickColorLabel.text = "Pick a color"
        pickColorLabel.textColor = UIColor.white
        pickColorLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
        
        NSLayoutConstraint.activate([
            pickColorLabel.heightAnchor.constraint(equalToConstant: 30),
            pickColorLabel.topAnchor.constraint(equalTo: habitColorPickerCard.topAnchor, constant: 15),
            pickColorLabel.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor, constant: 20),
            pickColorLabel.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor, constant: -20)
        ])
        
    }
    
    func configureStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let colorButtonsArray = [color1Button, color2Button, color3Button, color4Button, color5Button, color6Button, color7Button]
        
        habitColorPickerCard.addSubview(stackView)
        stackView.axis              = .horizontal
        stackView.distribution      = .equalSpacing
        
        func randomColorAtLoad() {
            let random = colorButtonsArray.randomElement()
            random?.isSelected = true
            random?.colorSelected()
            habitNameCard.backgroundColor = random?.colorButtonContentView.backgroundColor
        }
        
        for button in colorButtonsArray {
            button.colorPickerAction = {
                self.deselectAll()
                button.isSelected = true
                button.colorSelected()
                
                self.habitNameCard.backgroundColor = button.colorButtonContentView.backgroundColor
                
            }
            button.widthAnchor.constraint(equalToConstant: 37).isActive = true
            stackView.addArrangedSubview(button)
        }
        
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 38),
            stackView.topAnchor.constraint(equalTo: pickColorLabel.bottomAnchor, constant: 13),
            stackView.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor, constant: 13),
            stackView.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor, constant: -13)
        ])
        randomColorAtLoad()

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
        
        habitNameCard.addSubview(addHabitButton)
        addHabitButton.setImage(Icons.smallPlusIcon, for: .normal)
        addHabitButton.addTarget(self, action: #selector(self.saveHabitAndDismiss), for: .touchUpInside)
        
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
        
        habitNameCard.addSubview(leavePageButton)
        leavePageButton.setImage(Icons.chevronIcon, for: .normal)
        leavePageButton.addTarget(self, action: #selector(self.backToMainVC), for: .touchUpInside)
  
        NSLayoutConstraint.activate([
            leavePageButton.heightAnchor.constraint(equalToConstant: 30),
            leavePageButton.widthAnchor.constraint(equalToConstant: 31),
            leavePageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19),
            leavePageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)
        ])
    }
    
    
    @objc func saveHabitAndDismiss() {
        
        if ((habitNameLabel.text?.isEmpty) != true) {
            let newHabit = Habit()
            newHabit.title = habitNameLabel.text!
    //        newHabit.color = UIColor.systemBlue
            if avoidWeekendsSwitch.isOn {
                newHabit.avoidWeekends = true
            }
            
            self.save(habit: newHabit)
            
            delegate?.modalVCWillDismiss(self)
            
            self.dismiss(animated: true)
            
        } else {
            let alert = UIAlertController(title: "Don't forget to add a title!", message: "", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
    @objc func backToMainVC() {
        
        if ((habitNameLabel.text?.isEmpty) != true) {
            let alert = UIAlertController(title: "If you go back this habit won't be saved", message: "Do you still want to go back?", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { UIAlertAction in
                self.dismiss(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        } else {
            
            self.dismiss(animated: true)
        }
        
    }

}

extension CreateHabitViewController {
    
    private func deselectAll() {
        
        color1Button.isSelected = false
        color2Button.isSelected = false
        color3Button.isSelected = false
        color4Button.isSelected = false
        color5Button.isSelected = false
        color6Button.isSelected = false
        color7Button.isSelected = false
        
        color1Button.colorDeselected()
        color2Button.colorDeselected()
        color3Button.colorDeselected()
        color4Button.colorDeselected()
        color5Button.colorDeselected()
        color6Button.colorDeselected()
        color7Button.colorDeselected()
        
    }
}
