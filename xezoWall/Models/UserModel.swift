//
//  UserModel.swift
//  xezoWall
//
//  Created by mozeX on 05.10.2022.
//

import Foundation

class UserModel {
    
    var id: String?
    var displayName: String?
    var profileImageString: String?
    var email: String?
    var username: String?
    var username_lowercase: String?
    var isFollowing: Bool?
}

extension UserModel {
    
    static func transformDataToUser(dictionary: [String: Any], key: String) -> UserModel {
        let user = UserModel()
        user.id = key
        user.displayName = dictionary["displayName"] as? String
        user.profileImageString = dictionary["profileImageUrl"] as? String
        user.email = dictionary["email"] as? String
        user.username = dictionary["username"] as? String
        user.username_lowercase = dictionary["username_lowercase"] as? String
        return user
    }
}
