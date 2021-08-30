//
//  MainViewController.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/18/21.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    let realm = try! Realm()
    
    let addHabitButton = PCIconButton()
    let settingsButton = PCIconButton()
    
    var tableView = UITableView()
    var habits: Results<Habit>!
    
    lazy var yourFirstHabit: Bool = false
    
    struct Cells {
        static let habitCell = "HabitCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        loadData()
        configureUI()
//        refreshAtMidnight()
    }
    
    override open var shouldAutorotate: Bool {
            return false
        }
    
    func loadData() {
        habits = realm.objects(Habit.self).sorted(by: [SortDescriptor(keyPath: "isCompleted", ascending: true), SortDescriptor(keyPath: "creationDate", ascending: true)])
    }
    
//    // Resets isCompleted to false for every habit at midnight
//    func refreshAtMidnight() {
//        let calendar = Calendar.current
//                let now = Date()
//                let date = calendar.date(
//                      bySettingHour: 00,
//                      minute: 01,
//                      second: 0,
//                      of: now)!
//                let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(resetCompleteness), userInfo: nil, repeats: false)
//
//                  RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
//        tableView.reloadData()
//    }
    
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
        tableView.backgroundColor = .systemGray6
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
            addHabitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
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
        
        let createHabitVC = CreateHabitViewController()
        createHabitVC.delegate = self
        self.present(createHabitVC, animated: true)
    }

    @objc func presentSettingsVC() {
        self.present(SettingsViewController(), animated: true)
    }
    
//    // Resets isCompleted on every habit to false
//    @objc func resetCompleteness() {
//        for habit in habits {
//            try! realm.write {
//                habit.isCompleted = false
//            }
//        }
//    }

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
            tableView.reloadData()
//            cell.selectionStyle = UITableViewCell.SelectionStyle.none
//
//
////            let habit = self.habits[indexPath.row].title
//            let alert = UIAlertController(title: "Congratulations!", message: "You completed your first habit", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "Keep it up!", style: .default, handler: nil)
//            alert.addAction(okAction)
//
//
//
////            tableView.reloadData()
//
//            if yourFirstHabit == false {
//                self.present(alert, animated: true, completion: nil)
//                yourFirstHabit = true
//            }

        }
        
        reloadTableViewOnLoad = { [unowned self] in
            tableView.reloadData()
            print("MainVC tableview reloaded")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Habit \(String(describing: habits[indexPath.row].title)) cell was tapped")
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

extension MainViewController: CreateHabitDelegate {
    func modalVCWillDismiss(_ modalVC: CreateHabitViewController) {
        loadData()
        tableView.reloadData()
        print("Table view now reloaded")
    }
}

//
//extension MainViewController {
//
//    func fetchData() -> [Habit] {
//
//        let habitArray: [Habit] = [habit1, habit2, habit3, habit4, habit5, habit6]
//
//        let sortedHabits = habitArray.sorted {
//
//            if $0.completeness == $1.completeness {
//                return $0.title < $1.title
//            }
//            return $0.completeness == false && $1.completeness == true
//        }
//
//        return sortedHabits
//    }
//}
