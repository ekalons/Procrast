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
    
    var randomColor: UIColor? = nil
    var randomColorInHex: String = ""
    
    weak var delegate: CreateHabitDelegate?
    
    let realm = try! Realm()
    var habits: Results<Habit>!
    
    let addHabitButton  = PCIconButton()
    let leavePageButton = PCIconButton()
    
    let habitNameCard        = UIView()
    let habitColorPickerCard = UIView()
    let avoidWeekendCard     = UIView()
    let avoidWeekendLabel    = UILabel()
    
    let remindersCard             = UIView()
    let remindersLabel            = UILabel()
    let remindersSwitch           = UISwitch()
    var updatableLayoutConstraint = NSLayoutConstraint()
    var timePicker                = UIDatePicker()
    
    let habitNameLabel      = UITextField()
    let pickColorLabel      = UILabel()
    let avoidWeekendsSwitch = UISwitch()
    
    var pickedColor: UIColor? = nil
    
    let stackView = UIStackView()

    let redButton = PCRoundColorButton(),
        orangeButton = PCRoundColorButton(),
        yellowButton = PCRoundColorButton(),
        brightGreenButton = PCRoundColorButton(),
        paleGreenButton = PCRoundColorButton(),
        lightBlueButton = PCRoundColorButton(),
        darkBlueButton = PCRoundColorButton()
    
    
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
        view.backgroundColor = Colors.defaultBackgroundColor
        
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
        configureRemindersTimePicker()
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
        
        habitNameLabel.delegate = self
        
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
        
        updatableLayoutConstraint = remindersCard.heightAnchor.constraint(equalToConstant: 60)
        updatableLayoutConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            remindersCard.topAnchor.constraint(equalTo: avoidWeekendCard.bottomAnchor, constant: 12),
            remindersCard.leadingAnchor.constraint(equalTo: avoidWeekendCard.leadingAnchor),
            remindersCard.trailingAnchor.constraint(equalTo: avoidWeekendCard.trailingAnchor),
            
        ])
        
    }
    
    func configureRemindersSwitch() {
        remindersSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        remindersCard.addSubview(remindersSwitch)
        
        remindersSwitch.onTintColor = .systemBlue
        
        remindersSwitch.addTarget(self, action: #selector(onRemindersSwitchTap), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            remindersSwitch.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            remindersSwitch.centerYAnchor.constraint(equalTo: remindersCard.topAnchor, constant: 30)
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
            remindersLabel.centerYAnchor.constraint(equalTo: remindersCard.topAnchor, constant: 30),
        ])
        
    }
    
    func configureRemindersTimePicker() {
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        remindersCard.addSubview(timePicker)
        
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        // Will hide the time picker until the reminder switch is on
        timePicker.endEditing(true)
        timePicker.isHidden = true
        
        NSLayoutConstraint.activate([
            timePicker.centerXAnchor.constraint(equalTo: remindersCard.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: remindersSwitch.bottomAnchor, constant: 15),
            
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
        
        let colorButtonsArray = [redButton, orangeButton, yellowButton, brightGreenButton, paleGreenButton, lightBlueButton, darkBlueButton]
        
        habitColorPickerCard.addSubview(stackView)
        
        stackView.axis              = .horizontal
        stackView.distribution      = .equalSpacing
        
        func randomColorOnLoad() {
            let random = colorButtonsArray.randomElement()
            random?.isSelected = true
            random?.colorSelected()
            randomColor = random?.colorButtonContentView.backgroundColor
            habitNameCard.backgroundColor = randomColor
            // The line below is to save this color to Realm in case the user doesn't assign a color of their own
            randomColorInHex = randomColor?.toHexString() ?? "No random color defined"
        }
        
        for button in colorButtonsArray {
            button.colorPickerAction = {
                self.deselectAll()
                button.isSelected = true
                button.colorSelected()
                
                self.habitNameCard.backgroundColor = button.colorButtonContentView.backgroundColor
                
                self.pickedColor = button.colorButtonContentView.backgroundColor
                
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
        randomColorOnLoad()

    }

    
    func configureColorButtons() {
        
        view.addSubview(redButton)
        view.addSubview(orangeButton)
        view.addSubview(yellowButton)
        view.addSubview(brightGreenButton)
        view.addSubview(paleGreenButton)
        view.addSubview(lightBlueButton)
        view.addSubview(darkBlueButton)
        
        
        //Setting all colors
        redButton.colorButtonContentView.backgroundColor = UIColor.systemRed
        orangeButton.colorButtonContentView.backgroundColor = UIColor.systemOrange
        yellowButton.colorButtonContentView.backgroundColor = UIColor.systemYellow
        paleGreenButton.colorButtonContentView.backgroundColor = UIColor(red: 0.30, green: 0.67, blue: 0.31, alpha: 1.00)
        brightGreenButton.colorButtonContentView.backgroundColor = UIColor.systemGreen
        lightBlueButton.colorButtonContentView.backgroundColor = UIColor(red: 0.42, green: 0.72, blue: 1.00, alpha: 1.00)
        darkBlueButton.colorButtonContentView.backgroundColor = UIColor.systemBlue
        
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
            
            var reminderDate: Date? = nil
            
            if remindersSwitch.isOn {
                reminderDate = timePicker.date
            } else {
                reminderDate = nil
            }
            
            try! self.realm.write {
                self.realm.add(Habit(title: self.habitNameLabel.text!, color: self.pickedColor?.toHexString() ?? randomColorInHex, avoidWeekends: avoidWeekendsSwitch.isOn, reminderDate: reminderDate))
            }
            

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
    
    @objc func onRemindersSwitchTap() {
        
        if remindersSwitch.isOn {
            UIView.animate(withDuration: 0.15) {
                self.updatableLayoutConstraint.constant = 300
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                self.timePicker.isHidden = false
            }
            
        } else {
            UIView.animate(withDuration: 0.15) {
                self.timePicker.endEditing(true)
                self.timePicker.isHidden = true
                self.updatableLayoutConstraint.constant = 60
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }
        }
    }
}

extension CreateHabitViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
            var maxLength: Int = 0
            
            if textField == habitNameLabel {
                maxLength = 35
            }
            
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        
            return newString.length <= maxLength
        }}

extension CreateHabitViewController {
    
    private func deselectAll() {
        
        redButton.isSelected = false
        orangeButton.isSelected = false
        yellowButton.isSelected = false
        brightGreenButton.isSelected = false
        paleGreenButton.isSelected = false
        lightBlueButton.isSelected = false
        darkBlueButton.isSelected = false
        
        redButton.colorDeselected()
        orangeButton.colorDeselected()
        yellowButton.colorDeselected()
        brightGreenButton.colorDeselected()
        paleGreenButton.colorDeselected()
        lightBlueButton.colorDeselected()
        darkBlueButton.colorDeselected()
        
    }
}
