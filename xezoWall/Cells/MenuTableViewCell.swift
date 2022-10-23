//
//  MenuTableViewCell.swift
//  xezoWallpapers
//
//  Created by mozeX on 30.09.2022.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var imageMenu: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background
        self.backgroundColor = .clear
        
        // Icon
        self.imageMenu.tintColor = .white
        
        // Title
        self.titleLabel.textColor = .white
    }
}
