//
//  CategoriesTableViewCell.swift
//  xezoWall
//
//  Created by mozeX on 02.10.2022.
//

import Foundation
import UIKit

class CategoriesTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Background
        self.backgroundColor = .clear
        
        // Title
        self.titleLbl.textColor = .white
    }
    
}
