//
//  ViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 29.09.2022.
//

import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet var menuBtn: UIBarButtonItem!
    var categoriesVM: CategoriesVM!
    var apiManager: APIManager!
    var selectedCategory:String?
    var wallpapersListVM: WallpapersListVM!
    var selectedPage = arc4random_uniform(6) + 1
    var params:[String:String] = [:]
    var selectedIndexPath = IndexPath(row: 0, section: 0 )
    var categories = ["fashion","nature","backgrounds","science","education","people","feelings","religion","health","places","animals","industry","food","computer","sports","transportation","travel","buildings","business","music"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectedCat = ""
        if let category = selectedCategory {
            selectedCat = category
        } else {
            let randomIndex = Int(arc4random_uniform(UInt32(categories.count)))
            selectedCat = categories[randomIndex]
        }
        
        var perpage = 20
        if UIDevice.current.userInterfaceIdiom == .pad {
            perpage = 60
        }else{
            perpage = 20
        }
        params = [
            "category":selectedCat,
            "pretty":"true",
            "page": "\(selectedPage)",
            "per_page": "\(perpage)",
            "editors_choice":"true"
        ]
        
        self.view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        //navigationController?.navigationBar.tintColor = .white
        menuBtn.target = revealViewController()
        menuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        self.homeTableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        
        apiManager = APIManager(params: params)
        wallpapersListVM = WallpapersListVM()
        wallpapersListVM.getWallpapers(apiManager: apiManager) {
            self.homeTableView.reloadData()
        }
        categoriesVM = CategoriesVM(completion: { (index) in
            self.homeTableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        })

    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesVM != nil ? categoriesVM.categories.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { fatalError("xib doesn't exist") }
        cell.title.text = categoriesVM.categories[indexPath.row].title

        //cell.bgImage.kf.setImage(with: URL(string: wallpapersListVM.wallpapers[indexPath.row]. ?? "No Image"))
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.categoryVC) as! CategoryViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        //let vc = storyBoard.instantiateViewController(withIdentifier: NavControllers.categoryNav)
        //vc.receivedCategory = categoriesVM.categories[indexPath.row].title
        //vc.receivedCategory = categoriesVM.categories[indexPath.row].title
        
        vc.title = categoriesVM.categories[indexPath.row].title
        vc.selectedCategory = categoriesVM.categories[indexPath.row].title.lowercased()
        vc.pageTitle = categoriesVM.categories[indexPath.row].title
        
        vc.navigationItem.backButtonTitle? = "Hello"
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let cell = HomeTableViewCell()

//        if scrollView.contentOffset.y >= 200
//        {
//            self.navigationController?.navigationBar.fadeIn(duration: 0.7)
//            self.navigationController?.setNavigationBarHidden(false, animated: false)
//        }
//        else
//        {
//            navigationController?.navigationBar.fadeOut(duration: 0.7)
//            navigationController?.setNavigationBarHidden(true, animated: false)
//
//        }

//        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
//                // Bottom
//            }
//
//            if (scrollView.contentOffset.y < 0){
//                // Top
//
//                self.navigationController?.navigationBar.alpha = 1
//
//
//
//                //cell.bgImage.alpha = 1
//            }
//
//            if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
//                // Middle
//
//                let percentage: CGFloat = (scrollView.contentOffset.y) / 200
//
//                // This label loses alpha when you scroll down (or slide up)
//                //cell.bgImage.alpha = (0.7 - percentage)
//
//                // This label gets more alpha when you scroll up (or slide down)
//            }

        let visibleCells = homeTableView.visibleCells

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
        let tableViewTopPosition = homeTableView.frame.origin.y
        let tableViewBottomPosition = homeTableView.frame.origin.y + homeTableView.frame.size.height

        let topCellPositionInTableView = homeTableView.rectForRow(at: homeTableView.indexPath(for: topCell)!)
        let bottomCellPositionInTableView = homeTableView.rectForRow(at: homeTableView.indexPath(for: bottomCell)!)
        let topCellPosition = homeTableView.convert(topCellPositionInTableView, to: homeTableView.superview).origin.y
        let bottomCellPosition = homeTableView.convert(bottomCellPositionInTableView, to: homeTableView.superview).origin.y + cellHeight

        let modifier: CGFloat = 2.5
        let topCellOpacity = 1.0 - ((tableViewTopPosition - topCellPosition) / cellHeight) * modifier
        let bottomCellOpacity = 5.0 - ((bottomCellPosition - tableViewBottomPosition) / cellHeight) * modifier

        topCell.contentView.alpha = topCellOpacity
        bottomCell.contentView.alpha = bottomCellOpacity
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async {
            [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
