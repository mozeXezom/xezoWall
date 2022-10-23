//
//  DatabaseManager.swift
//  xezoWall
//
//  Created by mozeX on 07.10.2022.
//

import Foundation
import FirebaseDatabase

public class DatabaseManager {
    
    private let database = Database.database().reference()
    
    static let shared = DatabaseManager()
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func createNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username" : username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
        
    }
    
  
}

