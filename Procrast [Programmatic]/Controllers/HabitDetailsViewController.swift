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
    
    var habit: Habit?
    
    let realm = try! Realm()
    
    lazy var habitTitleLabel    = UILabel()
    lazy var streakLabel        = UILabel()
    lazy var streakSubLabel     = UILabel()
    lazy var containerView      = UIView()
    lazy var dimmedView         = UIView()
    
    lazy var streakCard = UIView()

    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [streakCard, spacer])
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
        
        configureHabitTitleLabel()
        configureStreakLabel()
        configureStreakSubLabel()
        configureContainerView()
        configureDimmedView()
        configureStreakCard()
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
    
    func setupConstraints() {
        // Add subviews
        view.addSubview(dimmedView)
        view.addSubview(containerView)
        view.addSubview(habitTitleLabel)
        streakCard.addSubview(streakLabel)
        streakCard.addSubview(streakSubLabel)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        habitTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
            contentStackView.heightAnchor.constraint(equalToConstant: 200),
            contentStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            // habitTitleLabel
            habitTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            habitTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 25),
            habitTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -25),
            
            // streakCard view
            streakCard.heightAnchor.constraint(equalToConstant: 120),
//            streakCard.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
//            streakCard.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            
            // streakLabel
            streakLabel.centerXAnchor.constraint(equalTo: streakCard.centerXAnchor),
            streakLabel.centerYAnchor.constraint(equalTo: streakCard.centerYAnchor),
            streakLabel.heightAnchor.constraint(equalTo: streakCard.heightAnchor),

            // streakSubLabel
            streakSubLabel.centerXAnchor.constraint(equalTo: streakCard.centerXAnchor),
            streakSubLabel.bottomAnchor.constraint(equalTo: streakCard.bottomAnchor, constant: -8),
            
            
            
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


