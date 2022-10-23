//
//  SettingsViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 25.09.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var menuOut: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        menuOut.target = revealViewController()
        menuOut.action = #selector(revealViewController()?.revealSideMenu)

    }

    @IBAction func menuPressed(_ sender: Any) {
        revealViewController()?.revealSideMenu()
    }
    
}

