//
//  DatabaseService.swift
//  xezoWall
//
//  Created by mozeX on 05.10.2022.
//

import FirebaseDatabase
import FirebaseStorage
import FirebaseAuth

class DatabaseService {
    // MARK: - SEND PROFILE IMAGE TO STORAGE
    static func sendProfileImageToStorage(with data: Data, onError: @escaping (String) -> Void, onSuccess: @escaping (_ profileImageString: String) -> Void) {
        let phototIdString = UUID().uuidString

        let storagePostRef = Storage.storage().reference().child(StorageLocation.Profile_Photos).child(phototIdString)

        storagePostRef.putData(data, metadata: nil, completion: { metadata, error in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            storagePostRef.downloadURL(completion: { url, urlError in
                guard let downloadUrl = url else { return }

                let postImageUrl = downloadUrl.absoluteString
                onSuccess(postImageUrl)
            })
        })
    }
}
