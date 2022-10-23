//
//  SubscriptionViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 01.10.2022.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        menuBtn.target = revealViewController()
        menuBtn.action = #selector(revealViewController()?.revealSideMenu)

    }
    
}
