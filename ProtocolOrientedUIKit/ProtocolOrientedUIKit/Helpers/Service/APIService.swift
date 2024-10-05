//
//  APIService.swift
//  ProtocolOrientedUIKit
//
//  Created by Barış Dilekçi on 5.10.2024.
//

import Foundation

protocol UserService {
    func fetch(completion: @escaping (Result<User, Error>) -> Void)
}

final class APIService: UserService {
    func fetch(completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                if let randomUser = users.randomElement() {
                    completion(.success(randomUser))
                } else {
                    completion(.failure(NSError(domain: "UserService", code: 0, userInfo: [NSLocalizedDescriptionKey: "No users found."])))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume() 
    }
}
