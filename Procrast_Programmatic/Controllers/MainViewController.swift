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


class MainViewController: UIViewController {
    
    // Realm DB
    let realm = try! Realm()
    var habitToPass: Habit?
    var habits: Results<Habit>!
    
    let notifications = NotificationPublisher()
    
    // Interface
    lazy var addHabitButton = PCIconButton()
    lazy var settingsButton = PCIconButton()
    
    var tableView = UITableView()
    
    // Haptic feedback
    private let generator = UIImpactFeedbackGenerator(style: .medium)
    
    
//    lazy var yourFirstHabit: Bool = false     // Future feature
    
    struct Cells {
        static let habitCell = "HabitCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The observer below triggers on DayChanged --> Resets habits at midnight
        NotificationCenter.default.addObserver(self, selector: #selector(dayChanged), name: .NSCalendarDayChanged, object: nil)
        
        view.backgroundColor = Colors.defaultBackgroundColor
        
        loadData()
        configureUI()
        
        // For when .NSCalendarDayChanged doesn't trigger [ie: When the app is closed]
        dayChanged()
        
        notifications.requestNotificationsPermission()

    }
    
    override open var shouldAutorotate: Bool {
            return false
        }
    
    func loadData() {
        habits = realm.objects(Habit.self).sorted(byKeyPath: "creationDate", ascending: true)
//        habits = realm.objects(Habit.self).sorted(by: [SortDescriptor(keyPath: "isCompleted", ascending: true), SortDescriptor(keyPath: "creationDate", ascending: true)])
    }
    
    func toggleItem(_ habit: Habit) {
        habit.toggleCompleted()
    }
    
    func configureUI() {
        configureTableView()
        configurePlusButton()
        configureGearButton()
        
    }
    
    
// MARK: Table configurations
    func configureTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = Colors.defaultBackgroundColor
        tableView.separatorColor = .clear
    
        setTableViewDelegates()
        tableView.rowHeight = 70
        tableView.register(HabitCell.self, forCellReuseIdentifier: Cells.habitCell)
        tableView.pinToEdges(to: view)
        
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
// MARK: Button configurations
    func configurePlusButton() {
        addHabitButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(addHabitButton)
        addHabitButton.setImage(Icons.plusIcon, for: .normal)
        addHabitButton.addTarget(self, action: #selector(presentHabitCreatingVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            addHabitButton.heightAnchor.constraint(equalToConstant: 35),
            addHabitButton.widthAnchor.constraint(equalToConstant: 36),
            addHabitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            addHabitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    func configureGearButton() {
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsButton)
        settingsButton.setImage(Icons.gearIcon, for: .normal)
        settingsButton.addTarget(self, action: #selector(presentSettingsVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            settingsButton.heightAnchor.constraint(equalToConstant: 35),
            settingsButton.widthAnchor.constraint(equalToConstant: 36.5),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 26),
            settingsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
    }
    
    // MARK: Present objc functions
    @objc func presentHabitCreatingVC() {
        
        generator.impactOccurred()
        
        let createHabitVC = CreateHabitViewController()
        createHabitVC.delegate = self
        self.present(createHabitVC, animated: true)
    }

    @objc func presentSettingsVC() {
        
        generator.impactOccurred()
        
        let settingsVC = SettingsViewController()
        self.present(settingsVC, animated: true)
    }
    
    @objc func presentHabitDetailsVC() {
        let habitDetailsVC = HabitDetailsViewController()
        habitDetailsVC.delegate = self
        
        habitDetailsVC.habit = habitToPass
        habitDetailsVC.modalPresentationStyle = .overCurrentContext
        self.present(habitDetailsVC, animated: false)
    }
    
    @objc func dayChanged() {
        print("Day change observer triggered")
        
        DispatchQueue.main.async {
            print("Current thread in \(#function) is \(Thread.current)")
            self.habits = self.realm.objects(Habit.self)
            
            // Resets Bool value in Realm & then buttons when the table view reloads
            func resetHabitCompleteness(habit: Habit) {
                if habit.streakList.last != Date().onlyDate {
                    try! self.realm.write {
                        habit.isCompleted = false
                    }
                }
            }
            
            for habit in self.habits {
                                
                // Doesn't restart habits if weekend
                if habit.avoidWeekends == true {
                    
                    // If weekday then...
                    if Calendar.current.isDateInWeekend(Date()) != true {
                        print("It is the weekend")
                        resetHabitCompleteness(habit: habit)
                    }
                // Restarts habits on weekends
                } else if habit.avoidWeekends != true {
                    resetHabitCompleteness(habit: habit)
                }
                
            }
            self.loadData()
            self.tableView.reloadData()
        }

    
    }
    

}

// MARK: Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.habitCell) as! HabitCell
        let habit = habits[indexPath.row]
        cell.set(habit: habit)
        
        // Read from Realm, then populate RadioButtonStatus-es accordingly
        cell.configureWith(habit) { [weak self] habit in
            self?.toggleItem(habit)
        }
        
        
        cell.radioButtonAction = { [unowned self] in
            self.tableView.reloadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Habit \(String(describing: habits[indexPath.row].title)) cell was tapped")
        
        habitToPass = habits[indexPath.row]
        perform(#selector(presentHabitDetailsVC), with: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MainViewController: CreateHabitDelegate {
    func modalVCWillDismiss(_ modalVC: CreateHabitViewController) {
        loadData()
        tableView.reloadData()
        print("Table view now reloaded after return from CreateHabitVC")
    }
}

extension MainViewController: HabitDetailsDelegate {
    func modalVCWillDismiss(_ modalVC: HabitDetailsViewController) {
        loadData()
        tableView.reloadData()
        print("Table view now reloaded after return from mini modal")
    }
}
