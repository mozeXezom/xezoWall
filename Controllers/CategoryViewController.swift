//
//  CategoryViewController.swift
//  xezoWall
//
//  Created by mozeX on 02.10.2022.
//

import UIKit
import Kingfisher

class CategoryViewController: UIViewController {
    
    @IBOutlet var myCollection: UICollectionView!
    var receivedCategory = String()
    var categoriesVM: CategoriesVM!
    var apiManager: APIManager!
    var pageTitle = "Your Wall"
    var selectedCategory:String?
    var wallpapersListVM: WallpapersListVM!
    var selectedIndex = IndexPath(row: 0, section: 0)
    var selectedPage = arc4random_uniform(6) + 1
    var params:[String:String] = [:]
    var categories = ["fashion","nature","backgrounds","science","education","people","feelings","religion","health","places","animals","industry","food","computer","sports","transportation","travel","buildings","business","music","space"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(receivedCategory)
        myCollection.dataSource = self
        myCollection.delegate = self
        myCollection.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        print(selectedCategory)
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
            perpage = 60
        }
        params = [
            "category":selectedCat,
            "pretty":"true",
            "page": "\(selectedPage)",
            "per_page": "\(perpage)",
            "editors_choice":"true"
        ]
        apiManager = APIManager(params: params)
        wallpapersListVM = WallpapersListVM()
        wallpapersListVM.getWallpapers(apiManager: apiManager) {
            self.myCollection.reloadData()
        }

        self.view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
    }
}

extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wallpapersListVM.wallpapers.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myCollection.dequeueReusableCell(withReuseIdentifier: Cells.postCell, for: indexPath) as! PostCollectionViewCell
        //cell.myImage.image = UIImage(named: data[indexPath.row])
        cell.imageView.kf.setImage(with: URL(string: wallpapersListVM.wallpapers[indexPath.row].previewURL ?? "No Image"))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width-10)/2
//        return CGSize(width: size, height: 420)
        return CGSize(
            width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == self.wallpapersListVM.wallpapers.count  { } else {
            self.selectedIndex = indexPath
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Controllers.wallpaperVC) as! WallpaperViewController
            //vc.selectedIndex = indexPath
            //vc.wallpapers = wallpapersListVM
            //vc.wallpaperImage.kf.setImage(with: URL(string: wallpapersListVM.wallpapers[indexPath.row].previewURL ?? "No Image"))
            vc.modalPresentationStyle = .fullScreen
            vc.receivedUrl = wallpapersListVM.wallpapers[indexPath.row].previewURL
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
}

