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
    
    // Realm DB
    let realm = try! Realm()
    var habits: Results<Habit>!
    
    // Navigation buttons & top screen card
    let addHabitButton  = PCIconButton()
    let leavePageButton = PCIconButton()
    let habitNameCard   = UIView()
    let habitNameLabel  = UITextField()
    
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [habitColorPickerCard, remindersCard, avoidWeekendsCard, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    
    // Color picker horizontal stackview
    let colorsStackView = UIStackView()
    let habitColorPickerCard  = UIView()
    let pickColorLabel        = UILabel()
    var pickedColor: UIColor? = nil
    
    let redButton           = PCRoundColorButton(),
        orangeButton        = PCRoundColorButton(),
        yellowButton        = PCRoundColorButton(),
        brightGreenButton   = PCRoundColorButton(),
        paleGreenButton     = PCRoundColorButton(),
        lightBlueButton     = PCRoundColorButton(),
        darkBlueButton      = PCRoundColorButton()
    
    // Reminders switch
    let remindersCard   = UIView()
    let remindersLabel  = UILabel()
    let pickATimeLabel  = UILabel()
    let dividerLine     = UIView()
    let remindersSwitch = UISwitch()
    var timePicker      = UIDatePicker()
    var updatableLayoutConstraint = NSLayoutConstraint()
    
    // Avoid weekends switch
    let avoidWeekendsCard   = UIView()
    let avoidWeekendsLabel  = UILabel()
    let avoidWeekendsSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboard()
        
        configureUI()
        setupConstraints()
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
        configureColorStackView()
        configureHabitNameLabel()
        
        // Avoid weekend switch
        configureAvoidWeekendsCard()
        configureAvoidWeekendsSwitch()
        configureAvoidWeekendsLabel()
        
        // Reminder switch
        configureRemindersCard()
        configureRemindersSwitch()
        configureRemindersLabel()
        configureRemindersTimePicker()
        configurePickATimeLabel()
    }
    
    func setupConstraints() {
        // Top habit name card & buttons
        view.addSubview(habitNameCard)
        habitNameCard.addSubview(addHabitButton)
        habitNameCard.addSubview(leavePageButton)
        view.addSubview(habitNameLabel)
        
        habitNameCard.translatesAutoresizingMaskIntoConstraints   = false
        addHabitButton.translatesAutoresizingMaskIntoConstraints  = false
        leavePageButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Content stack view
        view.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
    
        // Habit color picker
        habitColorPickerCard.addSubview(pickColorLabel)
        habitColorPickerCard.addSubview(colorsStackView)
        
        habitColorPickerCard.translatesAutoresizingMaskIntoConstraints = false
        pickColorLabel.translatesAutoresizingMaskIntoConstraints       = false
        colorsStackView.translatesAutoresizingMaskIntoConstraints      = false
        habitNameLabel.translatesAutoresizingMaskIntoConstraints       = false
        
        // Reminders switch / time picker
        remindersCard.addSubview(remindersLabel)
        remindersCard.addSubview(remindersSwitch)
        remindersCard.addSubview(timePicker)
        remindersCard.addSubview(pickATimeLabel)
        remindersCard.addSubview(dividerLine)
        
        remindersCard.translatesAutoresizingMaskIntoConstraints   = false
        remindersLabel.translatesAutoresizingMaskIntoConstraints  = false
        remindersSwitch.translatesAutoresizingMaskIntoConstraints = false
        timePicker.translatesAutoresizingMaskIntoConstraints      = false
        pickATimeLabel.translatesAutoresizingMaskIntoConstraints  = false
        dividerLine.translatesAutoresizingMaskIntoConstraints     = false
        
        // Avoid weekends switch
        avoidWeekendsCard.addSubview(avoidWeekendsLabel)
        avoidWeekendsCard.addSubview(avoidWeekendsSwitch)
        
        avoidWeekendsCard.translatesAutoresizingMaskIntoConstraints   = false
        avoidWeekendsLabel.translatesAutoresizingMaskIntoConstraints  = false
        avoidWeekendsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            // Habit name card view
            habitNameCard.heightAnchor.constraint(equalToConstant: 100),
            habitNameCard.widthAnchor.constraint(equalTo: view.widthAnchor),
            habitNameCard.topAnchor.constraint(equalTo: view.topAnchor),
            
            // Habit name label
            habitNameLabel.heightAnchor.constraint(equalToConstant: 30),
            habitNameLabel.bottomAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: -5),
            habitNameLabel.leadingAnchor.constraint(equalTo: habitNameCard.leadingAnchor, constant: 25),
            habitNameLabel.trailingAnchor.constraint(equalTo: habitNameCard.trailingAnchor, constant: -25),
            
            // Add habit button
            addHabitButton.heightAnchor.constraint(equalToConstant: 30),
            addHabitButton.widthAnchor.constraint(equalToConstant: 31),
            addHabitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            addHabitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            
            // Leave page button
            leavePageButton.heightAnchor.constraint(equalToConstant: 30),
            leavePageButton.widthAnchor.constraint(equalToConstant: 31),
            leavePageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19),
            leavePageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            
            // Content stack view
            contentStackView.topAnchor.constraint(equalTo: habitNameCard.bottomAnchor, constant: 15),
            contentStackView.heightAnchor.constraint(equalToConstant: 640),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            
            // Habit color picker card view
            habitColorPickerCard.heightAnchor.constraint(equalToConstant: 120),
            
            // Pick color label
            pickColorLabel.heightAnchor.constraint(equalToConstant: 30),
            pickColorLabel.topAnchor.constraint(equalTo: habitColorPickerCard.topAnchor, constant: 15),
            pickColorLabel.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor, constant: 20),
            pickColorLabel.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor, constant: -20),
            
            // Colors stack view
            colorsStackView.heightAnchor.constraint(equalToConstant: 38),
            colorsStackView.topAnchor.constraint(equalTo: pickColorLabel.bottomAnchor, constant: 13),
            colorsStackView.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor, constant: 13),
            colorsStackView.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor, constant: -13),
            
            // Reminders label
            remindersLabel.heightAnchor.constraint(equalToConstant: 30),
            remindersLabel.leadingAnchor.constraint(equalTo: remindersCard.leadingAnchor, constant: 20),
            remindersLabel.trailingAnchor.constraint(equalTo: remindersSwitch.leadingAnchor, constant: -20),
            remindersLabel.centerYAnchor.constraint(equalTo: remindersCard.topAnchor, constant: 30),
            
            // Reminders switch
            remindersSwitch.trailingAnchor.constraint(equalTo: colorsStackView.trailingAnchor),
            remindersSwitch.centerYAnchor.constraint(equalTo: remindersCard.topAnchor, constant: 30),
            
            // Reminders time picker
            timePicker.centerXAnchor.constraint(equalTo: remindersCard.centerXAnchor),
            timePicker.topAnchor.constraint(equalTo: remindersSwitch.bottomAnchor, constant: 15),
            timePicker.trailingAnchor.constraint(equalTo: colorsStackView.trailingAnchor, constant: 10),
            
            // Pick a time label
            pickATimeLabel.leadingAnchor.constraint(equalTo: remindersLabel.leadingAnchor),
            pickATimeLabel.centerYAnchor.constraint(equalTo: timePicker.centerYAnchor),
            
            // Divider line
            dividerLine.heightAnchor.constraint(equalToConstant: 2),
            dividerLine.topAnchor.constraint(equalTo: remindersSwitch.bottomAnchor, constant: 10),
            dividerLine.leadingAnchor.constraint(equalTo: remindersLabel.leadingAnchor),
            dividerLine.trailingAnchor.constraint(equalTo: remindersSwitch.trailingAnchor),
            
            // Avoid weekend card
            avoidWeekendsCard.heightAnchor.constraint(equalToConstant: 60),
            
            // Avoid weekends label
            avoidWeekendsLabel.heightAnchor.constraint(equalToConstant: 30),
            avoidWeekendsLabel.leadingAnchor.constraint(equalTo: avoidWeekendsCard.leadingAnchor, constant: 20),
            avoidWeekendsLabel.trailingAnchor.constraint(equalTo: avoidWeekendsSwitch.leadingAnchor, constant: -20),
            avoidWeekendsLabel.centerYAnchor.constraint(equalTo: avoidWeekendsCard.centerYAnchor),
            
            // Avoid weekends switch
            avoidWeekendsSwitch.trailingAnchor.constraint(equalTo: colorsStackView.trailingAnchor),
            avoidWeekendsSwitch.centerYAnchor.constraint(equalTo: avoidWeekendsCard.centerYAnchor),
        ])
    }
    
    
// MARK: Configuring views, buttons & constraints
    func configureHabitNameCardView() {
        habitNameCard.backgroundColor = UIColor.systemBlue
    }
    
    func configureHabitNameLabel() {
        habitNameLabel.delegate = self
        habitNameLabel.attributedPlaceholder = NSAttributedString(string: "Add a habit name here!", attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray2])
        habitNameLabel.textColor = UIColor.white
        habitNameLabel.becomeFirstResponder()
        
    }
    
    func configureHabitColorPickerCardView() {
        habitColorPickerCard.layer.cornerRadius = 15
        habitColorPickerCard.backgroundColor = .systemGray5
    }
    
    func configureAvoidWeekendsCard() {
        avoidWeekendsCard.layer.cornerRadius = 15
        avoidWeekendsCard.backgroundColor = .systemGray5
    }
    
    func configureAvoidWeekendsLabel() {
        avoidWeekendsLabel.text = "Avoid weekends"
        avoidWeekendsLabel.textColor = pickColorLabel.textColor
        avoidWeekendsLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
    }
    
    func configureAvoidWeekendsSwitch() {
        avoidWeekendsSwitch.onTintColor = .systemBlue
    }
    
    func configureRemindersCard() {
        remindersCard.layer.cornerRadius = 15
        remindersCard.backgroundColor = .systemGray5
        
        updatableLayoutConstraint = remindersCard.heightAnchor.constraint(equalToConstant: 60)
        updatableLayoutConstraint.isActive = true
    }
    
    func configureRemindersSwitch() {
        remindersSwitch.onTintColor = .systemBlue
        remindersSwitch.addTarget(self, action: #selector(onRemindersSwitchTap), for: .valueChanged)
    }
    
    @objc func onRemindersSwitchTap() {
        
        if remindersSwitch.isOn {
            UIView.animate(withDuration: 0.15) {
                self.updatableLayoutConstraint.constant = 120
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
                self.timePicker.isHidden = false
                self.pickATimeLabel.isHidden = false
                self.dividerLine.backgroundColor = .systemGray3
                
            }
            
        } else {
            UIView.animate(withDuration: 0.15) {
                self.updatableLayoutConstraint.constant = 60
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
                self.timePicker.endEditing(true)
                self.timePicker.isHidden = true
                self.pickATimeLabel.isHidden = true
                self.dividerLine.backgroundColor = .clear
            }
        }
    }
    
    func configureRemindersLabel() {
        remindersLabel.text = "Reminders"
        remindersLabel.textColor = pickColorLabel.textColor
        remindersLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
    }
    
    func configureRemindersTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .inline
        
        // Will hide the time picker until the reminder switch is on
        timePicker.endEditing(true)
        timePicker.isHidden = true
    }
    
    func configurePickATimeLabel() {
        pickATimeLabel.text = "Pick a time"
        pickATimeLabel.textColor = .white
    }
    
    
    func configurePickColorLabel() {
        pickColorLabel.text = "Pick a color"
        pickColorLabel.textColor = UIColor.white
        pickColorLabel.font = UIFont.systemFont(ofSize: 19, weight: .semibold)
    }
    
    func configureColorStackView() {
        let colorButtonsArray = [redButton, orangeButton, yellowButton, brightGreenButton, paleGreenButton, lightBlueButton, darkBlueButton]
        
        colorsStackView.axis         = .horizontal
        colorsStackView.distribution = .equalSpacing
        
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
            colorsStackView.addArrangedSubview(button)
        }
        
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
    
    
    
    // Configuring navigation buttons on top of screen
    func configureAddHabitButton() {
        addHabitButton.setImage(Icons.smallPlusIcon, for: .normal)
        addHabitButton.addTarget(self, action: #selector(self.saveHabitAndDismiss), for: .touchUpInside)
    }
    
    func configureLeavePageButton() {
        leavePageButton.setImage(Icons.chevronIcon, for: .normal)
        leavePageButton.addTarget(self, action: #selector(self.backToMainVC), for: .touchUpInside)
    }
    
    // Save to Realm and dismiss modal
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
    // Making sure user doesn't lose progress
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
        
        let colorButtonsArray = [redButton, orangeButton, yellowButton, brightGreenButton, paleGreenButton, lightBlueButton, darkBlueButton]
        
        for button in colorButtonsArray {
            button.isSelected = false
            button.colorDeselected()
        }
    }
    
}

extension UIViewController {
    
    func dismissKeyboard() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
       view.endEditing(true)
    }
}
