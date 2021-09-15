//The MIT License (MIT)
//
//Copyright (c) 2021 Ekaitz Alonso Larrea
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit
import RealmSwift

class HabitDetailsViewController: UIViewController {
    
    var pickedColor: UIColor?
    
    var habit: Habit?
    
    let realm = try! Realm()
    
    lazy var habitTitleLabel    = UILabel()
    lazy var streakLabel        = UILabel()
    lazy var streakSubLabel     = UILabel()
    lazy var containerView      = UIView()
    lazy var dimmedView         = UIView()
    lazy var pageLifter         = UIView()
    
    
    // Color picker
    lazy var habitColorPickerCard = UIView()
    let pickColorLabel = UILabel()
    let colorsStackView = UIStackView()
    let redButton = PCRoundColorButton(),
        orangeButton = PCRoundColorButton(),
        yellowButton = PCRoundColorButton(),
        paleGreenButton = PCRoundColorButton(),
        brightGreenButton = PCRoundColorButton(),
        lightBlueButton = PCRoundColorButton(),
        darkBlueButton = PCRoundColorButton()
    
    // Avoid weekends switch
    let avoidWeekendCard    = UIView()
    let avoidWeekendLabel   = UILabel()
    let avoidWeekendsSwitch = UISwitch()
    
    // Reminders switch
    let remindersCard   = UIView()
    let remindersLabel  = UILabel()
    let remindersSwitch = UISwitch()
    var timePicker      = UIDatePicker()
    var updatableLayoutConstraint = NSLayoutConstraint()
    
    lazy var streakCard = UIView()

    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let pageSeparator =  UIView()
        pageSeparator.heightAnchor.constraint(equalToConstant: 4).isActive = true
        let stackView = UIStackView(arrangedSubviews: [streakCard, pageSeparator, habitColorPickerCard, avoidWeekendCard, remindersCard, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    let maxDimmedAlpha: CGFloat = 0.6
    
    // Constants
    let defaultHeight: CGFloat = 210
    let dismissibleHeight: CGFloat = 200
    //
    let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 64
    // keep current new height, initial is default height
    var currentContainerHeight: CGFloat = 300
    
    // Dynamic container constraint
    var containerViewHeightConstraint: NSLayoutConstraint?
    var containerViewBottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupConstraints()
        // Tap gesture recognizer on dimmed view --> Dismiss
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleCloseAction))
        dimmedView.addGestureRecognizer(tapGesture)
        
        setupPanGesture()
    }
    
    @objc func handleCloseAction() {
        animateDismissView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateShowDimmedView()
        animatePresentContainer()
    }
    
    func configureUI() {
        view.backgroundColor = .clear
        
        configureContainerView()
        configureDimmedView()
        
        configurePageLifter()
        configureHabitTitleLabel()
        
        // Streaks
        configureStreakCard()
        configureStreakLabel()
        configureStreakSubLabel()
        
        // Color picker
        configureColorButtons()
        configureHabitColorPickerCardView()
        configurePickColorLabel()
        configureColorStackView()
        
        // Avoid weekend switch
        configureAvoidWeekendsCard()
        configureAvoidWeekendsLabel()
        configureAvoidWeekendSwitch()
        
        // Reminders switch, label & date picker
        configureRemindersCard()
        configureRemindersLabel()
        configureRemindersSwitch()
        configureRemindersTimePicker()
    }
    
    func configurePageLifter() {
        pageLifter.layer.cornerRadius = 3
        pageLifter.backgroundColor = .systemGray3
        
    }
    
    func configureHabitTitleLabel() {
        habitTitleLabel.text = habit?.title
        habitTitleLabel.font = .boldSystemFont(ofSize: 20)
        // Default to .systemBlue if something fails
        habitTitleLabel.textColor = UIColor(hexaString: habit?.color ?? "0a84ff")
    }
    
    func configureStreakCard() {
        streakCard.backgroundColor = .systemGray5
        streakCard.layer.cornerRadius = 17
    }
    func configureStreakLabel() {
        streakLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if habit!.streakCounter == 1 {
            streakLabel.text = "\(String(describing: habit!.streakCounter)) Day"
        } else {
            streakLabel.text = "\(String(describing: habit!.streakCounter)) Days"
        }
        
        streakLabel.font = .boldSystemFont(ofSize: 42)
        // Default to .systemBlue if something fails
        streakLabel.textColor = UIColor(hexaString: habit?.color ?? "0a84ff")
    }
    func configureStreakSubLabel() {
        streakSubLabel.translatesAutoresizingMaskIntoConstraints = false
        streakSubLabel.text = "Current streak"
        streakSubLabel.font = streakSubLabel.font.withSize(15)
        streakSubLabel.textColor = .systemGray2
    }
    func configureContainerView() {
        containerView.backgroundColor = Colors.defaultBackgroundColor
        containerView.layer.cornerRadius = 17
        containerView.clipsToBounds = true
    }
    func configureDimmedView() {
        dimmedView.backgroundColor = .black
        dimmedView.alpha = maxDimmedAlpha
    }
    
    func configureHabitColorPickerCardView() {
        habitColorPickerCard.layer.cornerRadius = 15
        habitColorPickerCard.backgroundColor = .systemGray5
        
    }
    func configurePickColorLabel() {
        pickColorLabel.text = "Pick a color"
        pickColorLabel.textColor = UIColor.white
        pickColorLabel.font = UIFont.systemFont(ofSize: 19, weight: .regular)
    }
    func configureColorStackView() {
        let colorButtonsArray = [redButton, orangeButton, yellowButton, brightGreenButton, paleGreenButton, lightBlueButton, darkBlueButton]
        
        colorsStackView.axis         = .horizontal
        colorsStackView.distribution = .equalSpacing
        
        func pickedColorOnLoad() {
            var habitColorButton = PCRoundColorButton()
            
            // Decides which color is picked from habit.color
            if habit!.color == "#ff453a" {
                habitColorButton = redButton
            } else if habit!.color == "#ff9f0a" {
                habitColorButton = orangeButton
            } else if habit!.color == "#ffd60a" {
                habitColorButton = yellowButton
            } else if habit!.color == "#4caa4f" {
                habitColorButton = paleGreenButton
            } else if habit!.color == "#30d158" {
                habitColorButton = brightGreenButton
            } else if habit!.color == "#6bb7ff" {
                habitColorButton = lightBlueButton
            } else if habit!.color == "#0a84ff" {
                habitColorButton = darkBlueButton
            }
            
            habitColorButton.isSelected = true
            habitColorButton.colorSelected()
            
            pickedColor = habitColorButton.colorButtonContentView.backgroundColor
            
            
        }
        
        for button in colorButtonsArray {
            button.colorPickerAction = {
                self.deselectAll()
                button.isSelected = true
                button.colorSelected()
                
                self.habitTitleLabel.textColor = button.colorButtonContentView.backgroundColor
                self.streakLabel.textColor = button.colorButtonContentView.backgroundColor
                
                self.pickedColor = button.colorButtonContentView.backgroundColor
                
                
            }
            button.widthAnchor.constraint(equalToConstant: 37).isActive = true
            colorsStackView.addArrangedSubview(button)
        }
        pickedColorOnLoad()
        
    }
    func configureColorButtons() {
        
        view.addSubview(redButton)
        view.addSubview(orangeButton)
        view.addSubview(yellowButton)
        view.addSubview(paleGreenButton)
        view.addSubview(brightGreenButton)
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
    
    func configureAvoidWeekendsCard() {
        avoidWeekendCard.layer.cornerRadius = 15
        avoidWeekendCard.backgroundColor = .systemGray5
    }

    func configureAvoidWeekendsLabel() {
        avoidWeekendLabel.text = "Avoid weekends"
        avoidWeekendLabel.textColor = pickColorLabel.textColor
        avoidWeekendLabel.font = UIFont.systemFont(ofSize: 19)
    }
    
    func configureAvoidWeekendSwitch() {
        avoidWeekendsSwitch.isOn = ((habit?.avoidWeekends) != nil)
        avoidWeekendsSwitch.onTintColor = .systemBlue
    }
    
    // MARK: Reminders switch/time picker
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
                self.updatableLayoutConstraint.constant = 270
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
    
    func configureRemindersLabel() {
        remindersLabel.text = "Reminders"
        remindersLabel.textColor = pickColorLabel.textColor
        remindersLabel.font = avoidWeekendLabel.font
    }
    
    func configureRemindersTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        
        // Will hide the time picker until the reminder switch is on
        timePicker.endEditing(true)
        timePicker.isHidden = true
    }
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(pageLifter)
        view.addSubview(habitTitleLabel)
        
        streakCard.addSubview(streakLabel)
        streakCard.addSubview(streakSubLabel)
        
        habitColorPickerCard.addSubview(pickColorLabel)
        habitColorPickerCard.addSubview(colorsStackView)
        
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Load before vertical stackview
        pageLifter.translatesAutoresizingMaskIntoConstraints = false
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Color picker
        habitColorPickerCard.translatesAutoresizingMaskIntoConstraints = false
        pickColorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Avoid weekends switch
        avoidWeekendCard.addSubview(avoidWeekendLabel)
        avoidWeekendCard.addSubview(avoidWeekendsSwitch)
        
        avoidWeekendCard.translatesAutoresizingMaskIntoConstraints = false
        avoidWeekendLabel.translatesAutoresizingMaskIntoConstraints = false
        avoidWeekendsSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        // Reminders switch / time picker
        remindersCard.addSubview(remindersLabel)
        remindersCard.addSubview(remindersSwitch)
        remindersCard.addSubview(timePicker)
        
        remindersCard.translatesAutoresizingMaskIntoConstraints = false
        remindersLabel.translatesAutoresizingMaskIntoConstraints = false
        remindersSwitch.translatesAutoresizingMaskIntoConstraints = false
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        
        
        containerView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // Set static constraints
        NSLayoutConstraint.activate([
            // set dimmedView edges to superview
            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // set container static constraint (trailing & leading)
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // content stackView
            contentStackView.topAnchor.constraint(equalTo: habitTitleLabel.bottomAnchor, constant: 15),
            contentStackView.heightAnchor.constraint(equalToConstant: 700),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            // pageLifter
            pageLifter.heightAnchor.constraint(equalToConstant: 5),
            pageLifter.widthAnchor.constraint(equalToConstant: 35),
            pageLifter.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            pageLifter.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // habitTitleLabel
            habitTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 23),
            habitTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            habitTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
            
            // streakCard view
            streakCard.heightAnchor.constraint(equalToConstant: 120),
            
            // streakLabel
            streakLabel.centerXAnchor.constraint(equalTo: streakCard.centerXAnchor),
            streakLabel.centerYAnchor.constraint(equalTo: streakCard.centerYAnchor),
            streakLabel.heightAnchor.constraint(equalTo: streakCard.heightAnchor),

            // streakSubLabel
            streakSubLabel.centerXAnchor.constraint(equalTo: streakCard.centerXAnchor),
            streakSubLabel.bottomAnchor.constraint(equalTo: streakCard.bottomAnchor, constant: -8),
            
            // habitColorPicker
            habitColorPickerCard.heightAnchor.constraint(equalToConstant: 120),
            
            // pickColorLabel
            pickColorLabel.heightAnchor.constraint(equalToConstant: 30),
            pickColorLabel.topAnchor.constraint(equalTo: habitColorPickerCard.topAnchor, constant: 15),
            pickColorLabel.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor, constant: 20),
            pickColorLabel.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor, constant: -20),

            // colorStackView
            colorsStackView.heightAnchor.constraint(equalToConstant: 38),
            colorsStackView.topAnchor.constraint(equalTo: pickColorLabel.bottomAnchor, constant: 13),
            colorsStackView.leadingAnchor.constraint(equalTo: habitColorPickerCard.leadingAnchor, constant: 13),
            colorsStackView.trailingAnchor.constraint(equalTo: habitColorPickerCard.trailingAnchor, constant: -13),
            
            // Avoid weekend card
            avoidWeekendCard.heightAnchor.constraint(equalToConstant: 60),
            
            // Avoid weekends label
            avoidWeekendLabel.heightAnchor.constraint(equalToConstant: 30),
            avoidWeekendLabel.leadingAnchor.constraint(equalTo: avoidWeekendCard.leadingAnchor, constant: 20),
            avoidWeekendLabel.trailingAnchor.constraint(equalTo: avoidWeekendsSwitch.leadingAnchor, constant: -20),
            avoidWeekendLabel.centerYAnchor.constraint(equalTo: avoidWeekendCard.centerYAnchor),
            
            // Avoid weekends switch
            avoidWeekendsSwitch.trailingAnchor.constraint(equalTo: colorsStackView.trailingAnchor),
            avoidWeekendsSwitch.centerYAnchor.constraint(equalTo: avoidWeekendCard.centerYAnchor),
            
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
            
            
        ])
        
        // Set dynamic constraints
        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        
        // By setting the height to default height, the container will be hide below the bottom anchor view
        // Later, will bring it up by set it to 0
        // set the constant to default height to bring it down again
        containerViewBottomConstraint = containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: defaultHeight)
        // Activate constraints
        containerViewHeightConstraint?.isActive = true
        containerViewBottomConstraint?.isActive = true
    }
    
    func setupPanGesture() {
        // add pan gesture recognizer to the view controller's view (the whole screen)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        // change to false to immediately listen on gesture movement
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }
    
    // MARK: Pan gesture handler
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        // Drag to top will be minus value and vice versa
        print("Pan gesture y offset: \(translation.y)")
        
        // Get drag direction
        let isDraggingDown = translation.y > 0
        print("Dragging direction: \(isDraggingDown ? "going down" : "going up")")
        
        // New height is based on value of dragging plus current container height
        let newHeight = currentContainerHeight - translation.y
        
        // Handle based on gesture state
        switch gesture.state {
        case .changed:
            // This state will occur when user is dragging
            if newHeight < maximumContainerHeight {
                // Keep updating the height constraint
                containerViewHeightConstraint?.constant = newHeight
                // refresh layout
                view.layoutIfNeeded()
            }
        case .ended:
            // This happens when user stop drag,
            // so we will get the last height of container
            
            // Condition 1: If new height is below min, dismiss controller
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            }
            else if newHeight < defaultHeight {
                // Condition 2: If new height is below default, animate back to default
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                // Condition 3: If new height is below max and going down, set to default height
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                // Condition 4: If new height is below max and going up, set to max height at top
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
    
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            // Update container height
            self.containerViewHeightConstraint?.constant = height
            // Call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
        // Save current height
        currentContainerHeight = height
    }
    
    // MARK: Present and dismiss animation
    func animatePresentContainer() {
        // update bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        // hide blur view
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            // once done, dismiss without animation
            self.dismiss(animated: false)
        }
        // hide main view by updating bottom constraint in animation block
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            // call this to trigger refresh constraint
            self.view.layoutIfNeeded()
        }
    }
}

extension HabitDetailsViewController {
    private func deselectAll() {
        
        redButton.isSelected = false
        orangeButton.isSelected = false
        yellowButton.isSelected = false
        paleGreenButton.isSelected = false
        brightGreenButton.isSelected = false
        lightBlueButton.isSelected = false
        darkBlueButton.isSelected = false
        
        redButton.colorDeselected()
        orangeButton.colorDeselected()
        yellowButton.colorDeselected()
        paleGreenButton.colorDeselected()
        brightGreenButton.colorDeselected()
        lightBlueButton.colorDeselected()
        darkBlueButton.colorDeselected()
        
    }
}

