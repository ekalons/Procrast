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

class HabitCell: UITableViewCell {
    
    private var habit: Habit?
    var habits: Results<Habit>!
    var radioSelectionStatus: Bool = false
    
    var habitTitleLabel      = UILabel()
    let habitCardView        = UIView()
    var radioButton          = PCHabitCellRadioButton()
    var radioButtonAction    : (() -> ())?
    
    // Haptic feedback
    private let generator = UIImpactFeedbackGenerator(style: .medium)

    
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
        radioButton.configureRadioViewOuterRingColor(userColorInHex: habit.color)
    }
    
    func configureWith(_ habit: Habit, onToggleCompleted: ((Habit) -> Void)? = nil) {
        self.habit = habit
        
        if habit.isCompleted == true {
            
            radioButton.radioSelected(userColorInHex: habit.color)
        
        } else {

            radioButton.radioDeselected(userColorInHex: habit.color)
        }
        
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
        habitTitleLabel.numberOfLines               = 1
        habitTitleLabel.adjustsFontSizeToFitWidth   = false
        habitTitleLabel.font                        = UIFont.systemFont(ofSize: 18, weight: .semibold)
        habitTitleLabel.textColor                   = .white
        
        NSLayoutConstraint.activate([
            habitTitleLabel.centerYAnchor.constraint(equalTo: radioButton.centerYAnchor),
            habitTitleLabel.leadingAnchor.constraint(equalTo: radioButton.trailingAnchor, constant: 8),
            habitTitleLabel.heightAnchor.constraint(equalToConstant: 40),
            habitTitleLabel.trailingAnchor.constraint(equalTo: habitCardView.trailingAnchor, constant: -12)
        
        ])
    }
    
    func manageRadioSelection() {
        radioSelectionStatus = !radioSelectionStatus
        if radioSelectionStatus == true {
            radioButton.radioSelected(userColorInHex: habit!.color)
            self.habit?.appendToStreak()

        } else {
            radioButton.radioDeselected(userColorInHex: habit!.color)
            self.habit?.popFromStreak()

        }

    }

    
    @objc func onRadioViewTap(_ sender: PCHabitCellRadioButton) {
        
        generator.impactOccurred()
        
        self.radioSelectionStatus = habit!.isCompleted
        
        // radioButtonAction will reload tableView data on every tap
        radioButtonAction?()
        
        manageRadioSelection()
        
        self.habit?.toggleCompleted()
        
    }

}
