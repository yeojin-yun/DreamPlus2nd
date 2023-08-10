//
//  PHPhotoLibraryChangeObserver.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/08/10.
//

import Photos
import PhotosUI
import UIKit

extension AlbumViewController: PHPhotoLibraryChangeObserver {
    
    func registerObserver() {
        PHPhotoLibrary.shared().register(self)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        DispatchQueue.main.async {
            if let albumChanges = changeInstance.changeDetails(for: albums) {
                print(albumChanges)
            }
        }
    }
    
    
}
