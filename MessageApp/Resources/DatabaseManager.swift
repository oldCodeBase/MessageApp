//
//  DatabaseManager.swift
//  MessageApp
//
//  Created by Ibragim Akaev on 12/01/2021.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    private let database = Database.database().reference()
}

//MARK: - Account Managment
extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    ///Insert a new user to database
    public func insertUser(with user: ChatAppUser) {
        database.child(user.emailAdress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAdress: String
//    let profilePictureUrl: String
}
