//
//  ImageUploder.swift
//  LoginAppUsingScrollView
//
//  Created by Admin on 09/08/22.
//

import UIKit
import FirebaseStorage

struct ImageUploder {
    
    static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
        
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        
        let fileName = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "profile_image/\(fileName)")
        
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print("DEBUG: fail to upload image \(error.localizedDescription)")
                return
            }
            
            ref.downloadURL( completion: { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                completion(imageUrl)
            })
        }
    }
}
