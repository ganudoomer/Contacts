//
//  ImageSaver.swift
//  Contacts
//
//  Created by Sree on 08/01/22.
//

import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage){
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage,didfinishSavingWithError error: Error?,contextInfo: UnsafeRawPointer){
        print("Save finished")
    }
    
}
