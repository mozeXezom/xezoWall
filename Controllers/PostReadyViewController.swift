//
//  PostReadyViewController.swift
//  xezoWall
//
//  Created by mozeX on 18.10.2022.
//

import UIKit

class PostReadyViewController: UIViewController {

    @IBOutlet weak var imageNew: UIImageView!
    var receivedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageNew.image = receivedImage

    }

}
