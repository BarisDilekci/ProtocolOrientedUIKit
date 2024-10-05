//
//  ViewController.swift
//  ProtocolOrientedUIKit
//
//  Created by Barış Dilekçi on 5.10.2024.
//

import UIKit

class UserListViewController: UIViewController, UserViewModelProtocol {
    
    private let viewModel : UserListViewModel
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .yellow
        viewModel.fetchUser()
    }
    
    init(viewModel: UserListViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
           self.viewModel.output = self
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    
    func updateView(name: String, email: String, userName: String) {
        DispatchQueue.main.async {
            self.usernameLabel.text = userName
            self.emailLabel.text = email
            self.nameLabel.text = name
        }
    }
    
    private func setupViews() {
        view.addSubview(emailLabel)
        view.addSubview(nameLabel)
        view.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60),
            nameLabel.widthAnchor.constraint(equalToConstant: 200),
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 60),
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 60),
            usernameLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10)
            
            
        ])
    }
    
}

