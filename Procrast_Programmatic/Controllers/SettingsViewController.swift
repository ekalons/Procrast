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
import SafariServices

class SettingsViewController: UIViewController {
    
    // Navigation
    let leavePageButton = PCIconButton()
    
    // UI content
    lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [aboutCardView, contactCardView, privacyCardView, spacer])
        stackView.axis = .vertical
        stackView.spacing = 12.0
        return stackView
    }()
    
    let aboutLabel = UILabel()
    let aboutCardView = UIView()
    
    // Personal photo/name
    lazy var profileStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [profileImageContainer, nameLabel])
        stackView.axis = .horizontal
        stackView.spacing = 20.0
        return stackView
    }()
    
    let profileImageContainer = UIView()
    let profileImageView = UIImageView(image: UIImage(named: "profile.PNG"))
    let nameLabel = UILabel()
    let bodyLabel = UILabel()
    
    // Contact
    let contactCardView = UIButton(type: .system)
    let contactLabel    = UILabel()
    
    // Privacy
    let privacyCardView = UIButton(type: .system)
    let privacyLabel    = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.defaultBackgroundColor
        
        configureUI()
        setupConstraints()
    }
    
    func configureUI() {
        //Navigation
        configureLeavePageButton()
        
        // Card view & title
        configureAboutLabel()
        configureAboutCardView()
        
        // Profile info & body
        configureProfileImageContainer()
        configureNameLabel()
        configureBodyLabel()
        
        // Contact
        configureContactCardView()
        configureContactLabel()
        
        // Privacy
        configurePrivacyCardView()
        configurePrivacyLabel()
        
        
    }
    
    func setupConstraints() {
        
        // Leave page button
        view.addSubview(leavePageButton)
        leavePageButton.translatesAutoresizingMaskIntoConstraints = false
        
        // About label
        view.addSubview(aboutLabel)
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Content stack view
        view.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // About card view
        aboutCardView.translatesAutoresizingMaskIntoConstraints = false
        
        // Profile image view & container
        aboutCardView.addSubview(profileStackView)
        profileStackView.translatesAutoresizingMaskIntoConstraints = false
        
        profileImageContainer.translatesAutoresizingMaskIntoConstraints = false
        profileImageContainer.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Name label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Body label
        aboutCardView.addSubview(bodyLabel)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Contact card view
        contactCardView.translatesAutoresizingMaskIntoConstraints = false
        
        contactCardView.addSubview(contactLabel)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Privacy card view
        privacyCardView.translatesAutoresizingMaskIntoConstraints = false
        privacyCardView.addSubview(privacyLabel)
        
        privacyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            
            // Leave page button
            leavePageButton.heightAnchor.constraint(equalToConstant: 30),
            leavePageButton.widthAnchor.constraint(equalToConstant: 31),
            leavePageButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 19),
            leavePageButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            
            aboutLabel.topAnchor.constraint(equalTo: leavePageButton.bottomAnchor, constant: 10),
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            
            // Content stack view
            contentStackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            contentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            
            // About card view
            aboutCardView.bottomAnchor.constraint(equalTo: bodyLabel.bottomAnchor, constant: 25),
            
            // Profile stack view
            profileStackView.topAnchor.constraint(equalTo: aboutCardView.topAnchor, constant: 22),
            profileStackView.leadingAnchor.constraint(equalTo: contentStackView.leadingAnchor, constant: 22),
            profileStackView.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -15),
            profileStackView.heightAnchor.constraint(equalToConstant: 95),
            
            // Profile image view container
            profileImageContainer.widthAnchor.constraint(equalToConstant: 95),
            
            // Profile image view
            profileImageView.topAnchor.constraint(equalTo: profileImageContainer.topAnchor, constant: -6),
            profileImageView.leadingAnchor.constraint(equalTo: profileImageContainer.leadingAnchor, constant: -14),
            profileImageView.heightAnchor.constraint(equalTo: profileImageContainer.heightAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalTo: profileImageContainer.widthAnchor, constant: 20),
            
            // Body label
            bodyLabel.topAnchor.constraint(equalTo: profileImageContainer.bottomAnchor, constant: 15),
            bodyLabel.leadingAnchor.constraint(equalTo: profileImageContainer.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: contentStackView.trailingAnchor, constant: -15),
            
            // Contact & card view
            contactCardView.heightAnchor.constraint(equalToConstant: 60),
            
            // Contact label
            contactLabel.centerYAnchor.constraint(equalTo: contactCardView.centerYAnchor),
            contactLabel.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor, constant: -3),
            contactLabel.trailingAnchor.constraint(equalTo: contactCardView.trailingAnchor, constant: -15),
            
            // Privacy card & label
            privacyCardView.heightAnchor.constraint(equalToConstant: 60),
            
            // Privacy label
            privacyLabel.centerYAnchor.constraint(equalTo: privacyCardView.centerYAnchor),
            privacyLabel.leadingAnchor.constraint(equalTo: bodyLabel.leadingAnchor,constant: -2),
            privacyLabel.trailingAnchor.constraint(equalTo: privacyCardView.trailingAnchor, constant: -15),
            
        
        ])
    }
        
    func configureLeavePageButton() {
        leavePageButton.setImage(Icons.chevronIcon, for: .normal)
        leavePageButton.addTarget(self, action: #selector(backToMainVC), for: .touchUpInside)
    }
    
    func configureAboutLabel() {
        aboutLabel.text = "About"
        aboutLabel.font = .boldSystemFont(ofSize: 25)
        aboutLabel.textColor = .white
    }
    
    func configureAboutCardView() {
        aboutCardView.backgroundColor = .systemGray5
        aboutCardView.layer.cornerRadius = 15
        
    }
    
    func configureProfileImageContainer() {
        profileImageContainer.layer.cornerRadius = 46
        profileImageContainer.backgroundColor = .systemTeal
        
    }
    
    func configureNameLabel() {
        nameLabel.text = "Hey, I'm Ekaitz"
        nameLabel.font = .boldSystemFont(ofSize: 22)
        nameLabel.textColor = .systemBlue
    }
    
    func configureBodyLabel() {
        bodyLabel.text = "I'm the sole software developer behind Procrast. I hope all fellow procrastinators out there find the app helpful. I wanted to mention that I'm open to feedback and suggestions so please don't hesitate to reach out with ideas!"
        bodyLabel.font = .systemFont(ofSize: 17)
        bodyLabel.numberOfLines = 0
        bodyLabel.setLineSpacing(lineSpacing: 5)
    }
    
    func configureContactCardView() {
        contactCardView.layer.cornerRadius = 15
        contactCardView.backgroundColor = Colors.cardColor
        
        contactCardView.addTarget(self, action: #selector(onContactTap), for: .touchUpInside)
    }
    
    func configureContactLabel() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "envelope")?.withTintColor(UIColor.white)

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: "  Contact me")
        imageString.append(textString)

        contactLabel.attributedText = imageString
        contactLabel.sizeToFit()
        contactLabel.textColor = .white
        contactLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    @objc func onContactTap() {
        
        let mailtoString = "mailto:\(PrivateCons.myEmail)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let mailtoUrl = URL(string: mailtoString!)!
        
        if UIApplication.shared.canOpenURL(mailtoUrl) {
            UIApplication.shared.open(mailtoUrl, options: [:])
        }
    }
    
    func configurePrivacyCardView() {
        privacyCardView.layer.cornerRadius = 15
        privacyCardView.backgroundColor = Colors.cardColor
        
        privacyCardView.addTarget(self, action: #selector(onPrivacyTap), for: .touchUpInside)
    }
    
    func configurePrivacyLabel() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "hand.raised")?.withTintColor(UIColor.white)

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: "  Privacy")
        imageString.append(textString)

        privacyLabel.attributedText = imageString
        privacyLabel.sizeToFit()
        privacyLabel.textColor = .white
        privacyLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    @objc func onPrivacyTap() {
        guard let url = URL(string: "https://www.termsfeed.com/live/14d614e0-2a89-41d8-a44b-5472700d5e73") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
    
    @objc func backToMainVC() {
        dismiss(animated: true)
    }
    
    
}


