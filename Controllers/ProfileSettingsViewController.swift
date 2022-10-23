//
//  ProfileSettingsViewController.swift
//  xezoWall
//
//  Created by mozeX on 05.10.2022.
//

import UIKit

class ProfileSettingsViewController: UIViewController {

    @IBOutlet weak var bgBlur: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bgBlur.backgroundColor = UIColor(white: 1, alpha: 0.1)

    }
}
