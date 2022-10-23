//
//  AuthManager.swift
//  xezoWall
//
//  Created by mozeX on 05.10.2022.
//

import Foundation
import FirebaseAuth

public class AuthManager {
    
    static let shared = AuthManager()
    
    public func registerNewUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void) {
        DatabaseManager.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                    guard error == nil, authResult != nil else {
                        completion(false)
                        return
                    }
                    DatabaseManager.shared.createNewUser(with: email, username: username) { (inserted) in
                        if inserted {
                            if let uid = Auth.auth().currentUser?.uid {
                                self.setUserInformation(
                                                        username: username,
                                                        email: email,
                                                        uid: uid)
                            }
                            completion(true)
                            return
                        } else {
                            completion(false)
                            return
                        }
                    }
                    
                }
            } else {
                completion(false)
            }
        }
    }
    
    func setUserInformation(username: String, email: String, uid: String) {
    
            Api.Users.REF_USERS.child(uid).setValue([
                "username"           : username,
                "username_lowercase" : username.lowercased(),
                "email"              : email
                ])

    }
    
    // MARK: - LOGIN USER
    static func loginWith(email: String, password: String, onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion:  { user, error in
            if error != nil  {
                onError(error!.localizedDescription)
                return
            }
            onSuccess()
        })
    }
}
