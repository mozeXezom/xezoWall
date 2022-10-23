//
//  MenuViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 30.09.2022.
//

import UIKit

protocol MenuViewControllerDelegate {
    func selectedCell(_ row: Int)
}

class MenuViewController: UIViewController {
    @IBOutlet var headerImageView: UIImageView!
    @IBOutlet var sideMenuTableView: UITableView!
    @IBOutlet var footerLabel: UILabel!
    @IBOutlet var menuView: UIView!
    
    var defaultHighlightedCell: Int = 0
    var delegate: MenuViewControllerDelegate?
    var categoriesVM: CategoriesVM!

    var menu: [MenuModel] = [
        MenuModel(icon: UIImage(named: "homeImg")!, title: "Home"),
        MenuModel(icon: UIImage(named: "profileImg")!, title: "Profile"),
        MenuModel(icon: UIImage(named: "settingsImg")!, title: "Settings"),
        MenuModel(icon: UIImage(named: "subscriptionImg")!, title: "Subscription"),
        MenuModel(icon: UIImage(named: "favoritesImg")!, title: "Favorites"),
        MenuModel(icon: UIImage(named: "contact")!, title: "Contact us"),
        MenuModel(icon: UIImage(named: "infoImg")!, title: "About xezoWall")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuView.addRightBorder(in: .purple, width: 1)
        

        // TableView
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.sideMenuTableView.separatorStyle = .none

        // Set Highlighted Cell
        DispatchQueue.main.async {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.sideMenuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
        }

        // Footer
        self.footerLabel.textColor = UIColor.white
        self.footerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        self.footerLabel.text = "Developed by xezoM"

        // Register TableView Cell
        self.sideMenuTableView.register(MenuTableViewCell.nib, forCellReuseIdentifier: MenuTableViewCell.identifier)
        self.sideMenuTableView.register(CategoriesTableViewCell.nib, forCellReuseIdentifier: CategoriesTableViewCell.identifier)

        // Update TableView with the data
        categoriesVM = CategoriesVM(completion: { (index) in
            self.sideMenuTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        })
        //self.sideMenuTableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.menu.count
        case 1:
            return categoriesVM != nil ? categoriesVM.categories.count : 0
        default:
            return 2
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.identifier, for: indexPath) as? MenuTableViewCell else { fatalError("xib doesn't exist") }

            cell.imageMenu.image = self.menu[indexPath.row].icon
            cell.titleLabel.text = self.menu[indexPath.row].title

            // Highlighted color
            cell.backgroundColor = UIColor(white: 1, alpha: 0.1)
            let myCustomSelectionColorView = UIView()
            myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            cell.selectedBackgroundView = myCustomSelectionColorView
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier, for: indexPath) as? CategoriesTableViewCell else { fatalError("xib doesn't exist") }

            cell.titleLbl.text = categoriesVM.categories[indexPath.row].title

            // Highlighted color
            let myCustomSelectionColorView = UIView()
            myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            cell.selectedBackgroundView = myCustomSelectionColorView
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ...
        self.delegate?.selectedCell(indexPath.row)
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
//        if indexPath.row == 4 || indexPath.row == 6 {
//            tableView.deselectRow(at: indexPath, animated: true)
//        }
    }
}

extension MenuViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleCells = sideMenuTableView.visibleCells

        if visibleCells.count == 0 {
            return
        }

        guard let bottomCell = visibleCells.last else {
            return
        }

        guard let topCell = visibleCells.first else {
            return
        }

        for cell in visibleCells {
            cell.contentView.alpha = 1.0
        }

        let cellHeight = topCell.frame.size.height - 1
        let tableViewTopPosition = sideMenuTableView.frame.origin.y
        let tableViewBottomPosition = sideMenuTableView.frame.origin.y + sideMenuTableView.frame.size.height

        let topCellPositionInTableView = sideMenuTableView.rectForRow(at: sideMenuTableView.indexPath(for: topCell)!)
        let bottomCellPositionInTableView = sideMenuTableView.rectForRow(at: sideMenuTableView.indexPath(for: bottomCell)!)
        let topCellPosition = sideMenuTableView.convert(topCellPositionInTableView, to: sideMenuTableView.superview).origin.y
        let bottomCellPosition = sideMenuTableView.convert(bottomCellPositionInTableView, to: sideMenuTableView.superview).origin.y + cellHeight

        let modifier: CGFloat = 2.5
        let topCellOpacity = 1.0 - ((tableViewTopPosition - topCellPosition) / cellHeight) * modifier
        let bottomCellOpacity = 1.0 - ((bottomCellPosition - tableViewBottomPosition) / cellHeight) * modifier

        topCell.contentView.alpha = topCellOpacity
        bottomCell.contentView.alpha = bottomCellOpacity
    }
}
