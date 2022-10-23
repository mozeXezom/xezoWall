//
//  WallpapersListVM.swift
//  xezoWall
//
//  Created by mozeX on 02.10.2022.
//

import Foundation

class WallpapersListVM {
    
    var apiManager: APIManager!
    var wallpapers: [WallpaperVM] = []
    
    func getWallpapers(apiManager: APIManager ,completion:@escaping ()->()) {
        self.apiManager = apiManager
        apiManager.getWallpapers { (wallpapers, error) in
            if let error = error {
                print("error:\(error)")
                fatalError()
            }
            self.wallpapers += wallpapers.compactMap(WallpaperVM.init)
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}

class WallpaperVM {
    
    let largeImageURL: String
    let webformatHeight, webformatWidth, likes, imageWidth: Int
    let id, userID: Int
    let imageURL: String?
    let views, comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let idHash, type: String
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
    
    init(wallpaper: WallpapersModel) {
        self.largeImageURL = wallpaper.largeImageURL
        self.webformatHeight = wallpaper.webformatHeight
        self.webformatWidth = wallpaper.webformatWidth
        self.likes = wallpaper.likes
        self.imageWidth = wallpaper.imageWidth
        self.id = wallpaper.id
        self.userID = wallpaper.userID
        self.imageURL = wallpaper.imageURL
        self.views = wallpaper.views
        self.comments = wallpaper.comments
        self.pageURL = wallpaper.pageURL
        self.imageHeight = wallpaper.imageHeight
        self.webformatURL = wallpaper.webformatURL
        self.idHash = wallpaper.idHash ?? "Nothing"
        self.type = wallpaper.type ?? "Nothing"
        self.previewHeight = wallpaper.previewHeight
        self.tags = wallpaper.tags
        self.downloads = wallpaper.downloads
        self.user = wallpaper.user
        self.favorites = wallpaper.favorites ?? 0
        self.imageSize = wallpaper.imageSize
        self.previewWidth = wallpaper.previewWidth
        self.userImageURL = wallpaper.userImageURL
        self.fullHDURL = wallpaper.fullHDURL ?? "Nothing"
        self.previewURL = wallpaper.previewURL ?? "Nothing"
    }
}
