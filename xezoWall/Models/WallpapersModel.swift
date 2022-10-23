//
//  WallpapersModel.swift
//  xezoWall
//
//  Created by mozeX on 02.10.2022.
//

import Foundation

struct WallpapersModel: Codable {
    
    let largeImageURL: String
    let webformatHeight, webformatWidth, likes, imageWidth: Int
    let id, userID: Int
    let imageURL: String?
    let views, comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let idHash, type: String?
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites, imageSize, previewWidth: Int?
    let userImageURL, fullHDURL, previewURL: String?
    
    enum CodingKeys: String, CodingKey {
        case largeImageURL, webformatHeight, webformatWidth, likes, imageWidth, id
        case userID = "user_id"
        case imageURL, views, comments, pageURL, imageHeight, webformatURL
        case idHash = "id_hash"
        case type, previewHeight, tags, downloads, user, favorites, imageSize, previewWidth, userImageURL, fullHDURL, previewURL
    }
    
}
