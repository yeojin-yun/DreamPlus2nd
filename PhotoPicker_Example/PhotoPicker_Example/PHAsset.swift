//
//  PHAsset.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/31.
//

import UIKit
import Photos

extension PHAsset {
    func getImageFromAsset(size: CGSize) -> UIImage {
        let manager = PHImageManager.default()
        
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        var thumnail = UIImage()
        
        manager.requestImage(for: self, targetSize: size, contentMode: .aspectFill, options: options) { image, _ in
            if let image = image {
                thumnail = image
            }
        }
        return thumnail
    }
}
