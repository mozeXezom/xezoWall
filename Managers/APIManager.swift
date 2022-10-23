//
//  APIManager.swift
//  xezoWall
//
//  Created by mozeX on 02.10.2022.
//

import UIKit

class APIManager {
    
    var baseURL = "https://pixabay.com/api/?key=30307581-70643813e18f4c1f6a3048bdb"
    var params:[String:String] = [:]
    
    init(params:[String:String]) {
        self.params = params
        for param in params {
            let value = param.value.replacingOccurrences(of: " ", with: "+")
            baseURL += "&"
            baseURL += "\(param.key)=\(value)"
        }
    }
    
    func getWallpapers(completion:@escaping ([WallpapersModel],Error?) -> ()) {
        
        let reqUrl = URL(string: baseURL)
        URLSession.shared.dataTask(with: reqUrl!) { (data, _, error) in
            do {
                if let data = data {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                    let json = jsonData as! [String:Any]
                    let wallsJson = json["hits"] as! [[String:Any]]
                    let wallsData = try JSONSerialization.data(withJSONObject: wallsJson, options: [])
                    let walls = try JSONDecoder().decode([WallpapersModel].self, from: wallsData)
                    DispatchQueue.main.async {
                        completion(walls,error)
                    }
                }
            } catch {
                print(error)
            }
        }.resume()
        
    }
    
    static func downloadImage(url:String,completion:@escaping (UIImage)->()) {
        
        if let url = URL(string: url) {
            DispatchQueue.global().async {
                
                let data = NSData.init(contentsOf: url)
                DispatchQueue.main.async {
                    
                    let image = UIImage(data: data! as Data)
                    completion(image!)
                }
            }
        }
        
    }
    
}
