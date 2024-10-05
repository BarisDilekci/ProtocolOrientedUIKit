//
//  UserList.swift
//  ProtocolOrientedUIKit
//
//  Created by Barış Dilekçi on 5.10.2024.
//

import Foundation

protocol UserViewModelProtocol : AnyObject {
    func updateView(name: String, email: String, userName: String)
}

final class UserListViewModel {
    private let userService : UserService!
    weak var output: UserViewModelProtocol?
    
    init(userService: UserService!) {
        self.userService = userService
    }
    
    func fetchUser() {
        userService.fetch { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.updateView(name: user.name, email: user.email, userName: user.username)
            case .failure(_):
                self?.output?.updateView(name: "No user", email: "", userName: "")
            }
        }
    }
    
}
