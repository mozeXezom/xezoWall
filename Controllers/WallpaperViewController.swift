//
//  WallpaperViewController.swift
//  xezoWall
//
//  Created by mozeX on 04.10.2022.
//

import UIKit
import Spring
import Kingfisher

class WallpaperViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var wallpaperImage: SpringImageView!
    var receivedUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(receivedUrl)
        self.wallpaperImage.kf.setImage(with: URL(string: receivedUrl ?? "No Image"))
        addSwipe()
        //wallpaperImage.autostart = true

    }
    
    func addSwipe() {
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        swipeleft.direction = UISwipeGestureRecognizer.Direction.left
        
        let swiperight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight))
        swiperight.direction = UISwipeGestureRecognizer.Direction.right
        
        wallpaperImage.addGestureRecognizer(swiperight)
        wallpaperImage.addGestureRecognizer(swipeleft)
    }
    
    @objc func swipeLeft() {
        
        wallpaperImage.velocity = 10
        wallpaperImage.animation = "fadeInLeft"
        wallpaperImage.curve = "easeIn"
        wallpaperImage.animate()
        //getImage()
        
    }
    
    @objc func swipeRight() {
        
        wallpaperImage.velocity = 10
        wallpaperImage.animation = "fadeInRight"
        wallpaperImage.curve = "easeIn"
        wallpaperImage.animate()
        //getImage()
        
    }
    
}
