//
//  MainViewController.swift
//  Procrast [Programmatic]
//
//  Created by Ekaitz on 5/18/21.
//

import UIKit

class MainViewController: UIViewController {
    
    let createHabitButton   = PCIconButton()
    let settingsButton      = PCIconButton()
    var tableView = UITableView()
    var habits: [Habit] = []
    
    var yourFirstHabit: Bool = false
    
    struct Cells {
        static let habitCell = "HabitCell"
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "This is the title of the navigation bar, if I were to have one"
        habits = fetchData()

        view.backgroundColor = .systemGray6
        
        configureUI()
    }
    
    func configureUI() {
        configureTableView()
        configurePlusButton()
        configureGearButton()
        
    }
    
    
//MARK: Table configurations
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
        createHabitButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(createHabitButton)
        createHabitButton.setImage(Icons.plusIcon, for: .normal)
        createHabitButton.addTarget(self, action: #selector(presentHabitCreatingVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            createHabitButton.heightAnchor.constraint(equalToConstant: 35),
            createHabitButton.widthAnchor.constraint(equalToConstant: 36),
            createHabitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            createHabitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
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
            settingsButton.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 30),
            settingsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
    }
    
    // MARK: Present objc functions
    @objc func presentHabitCreatingVC() {
        present(CreateHabitViewController(), animated: true)
    }

    @objc func presentSettingsVC() {
        present(SettingsViewController(), animated: true)
    }

}

//MARK: Extensions
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.habitCell) as! HabitCell
        let habit = habits[indexPath.row]
        cell.set(habit: habit)
        
        cell.radioButtonAction = { [unowned self] in
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            
//            let habit = self.habits[indexPath.row].title
            let alert = UIAlertController(title: "Congratulations!", message: "You completed your first habit", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Keep it up!", style: .default, handler: nil)
            alert.addAction(okAction)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.default
            
            if yourFirstHabit == false {
                self.present(alert, animated: true, completion: nil)
                yourFirstHabit = true
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Habit \(habits[indexPath.row].title) cell was tapped")
        tableView.deselectRow(at: indexPath, animated: true)
    }

}



extension MainViewController {
    
    func fetchData() -> [Habit] {
        
        //This is dummy data that will be replaced with a meaningful Realm function to retrieve data
        
//        let habit1 = Habit(icon: Icons.lightBulbIcon.withTintColor(.systemYellow, renderingMode: .alwaysOriginal),
        
        let habit1 = Habit(color: .systemBlue, title: "Read news")
        let habit2 = Habit(color: .systemRed, title: "Add expenses to Excel")
        let habit3 = Habit(color: .systemPink, title: "Read 1 hour")
        let habit4 = Habit(color: .systemGreen, title: "Do something creative")
        let habit5 = Habit(color: .systemYellow, title: "Run for 45 minutes")
        let habit6 = Habit(color: .systemBlue, title: "Prepare a healthy meal")
        
        
        return [habit1, habit2, habit3, habit4, habit5, habit6]
    }
}
