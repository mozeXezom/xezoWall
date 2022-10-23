//
//  Config.swift
//  xezoWall
//
//  Created by mozeX on 05.10.2022.
//

import FirebaseStorage
import FirebaseDatabase

struct StorageLocation {
    static let Root_Ref = Storage.storage().reference()
    static let Profile_Photos = "profile_photos"
    static let Posts = "posts"
}

struct DatabaseLocation {
    static let posts = "posts"
    static let comments = "comments"
    static let post_comments = "post_comments"
    static let user_posts = "user_posts"
    static let followers = "followers"
    static let following = "following"
    static let feed = "feed"
    static let hashtag = "hashtag"
    static let notification = "notification"
}

struct Colors {
    static let tint = UIColor(red: 218/255, green: 117/255, blue: 83/255, alpha: 1.0)
}
