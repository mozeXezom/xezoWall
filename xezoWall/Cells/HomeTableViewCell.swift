//
//  HomeTableViewCell.swift
//  xezoWall
//
//  Created by mozeX on 01.10.2022.
//

import UIKit

protocol HomeCellDelegate: AnyObject {
    func btnUseTap(cell: HomeTableViewCell)
}

class HomeTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    weak var delegate: HomeCellDelegate?

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgImage.layer.cornerRadius = 30
    }
    
}
