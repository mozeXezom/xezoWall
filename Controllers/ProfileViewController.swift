//
//  ProfileViewController.swift
//  xezoWallpapers
//
//  Created by mozeX on 27.09.2022.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var profileBg: UIImageView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var config = YPImagePickerConfiguration()
    var imagePicker: ImagePicker!
    var images = ["regBg","someBg","profileBg","menu","new","xezoLogo","aga","backImg","gradient","logos","settingsImg","someLogo","homeImg","favoritesImg","logoNew","subscriptionImg","logoNews","infoImg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
        
        setupConfig()
        
        let anyAvatarImage:UIImage = UIImage(named: "regBg")!
        profileImg.image = anyAvatarImage
        profileImg.roundedImage()
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        profileCollectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        menuBtn.target = revealViewController()
        menuBtn.action = #selector(revealViewController()?.revealSideMenu)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.cellTappedMethod(_:)))
        profileImg.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @IBAction func createPostPressed(_ sender: Any) {
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera) // Image source (camera or library)
                print(photo.image) // Final image selected by the user
                print(photo.originalImage) // original image selected by the user, unfiltered
                print(photo.modifiedImage) // Transformed image, can be nil
                print(photo.exifMeta) // Print exif meta data of original image.
            }
            picker.dismiss(animated: true, completion: nil)
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.postReadyVC) as! PostReadyViewController
                vc.modalPresentationStyle = .fullScreen
                print("IMAGE IS \(items.singlePhoto?.image)")
                vc.receivedImage = items.singlePhoto?.image
                self.present(vc, animated: true, completion: nil)
            }
        }
        present(picker, animated: true, completion: nil)
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.postCreationVC) as! PostCreationViewController
//        vc.modalTransitionStyle = .flipHorizontal
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)
        
    }
    
    func setupConfig() {
        config.isScrollToChangeModesEnabled = true
        config.onlySquareImagesFromCamera = true
        config.usesFrontCamera = false
        config.showsPhotoFilters = true
        config.showsVideoTrimmer = true
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.photo
        config.screens = [.library, .photo, .video, .postCreateVC]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.hidesBottomBar = false
        config.hidesCancelButton = false
        config.preferredStatusBarStyle = UIStatusBarStyle.default
        //config.bottomMenuItemSelectedColour = UIColor(r: 38, g: 38, b: 38)
        //config.bottomMenuItemUnSelectedColour = UIColor(r: 153, g: 153, b: 153)
    }
    
    @IBAction func profileSettingsPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: Controllers.profileSettingsVC) as! ProfileSettingsViewController
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @objc func cellTappedMethod(_ sender: AnyObject) {
        self.imagePicker.present(from: profileImg)
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.postCell, for: indexPath) as! PostCollectionViewCell
        cell.imageView.image = UIImage(named: images[indexPath.row])
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3
        )
        
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

extension ProfileViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        self.profileImg.image = image
    }
}


