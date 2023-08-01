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
        var thumnail = UIImage()
        options.isSynchronous = true
        manager.requestImage(for: self, targetSize: size, contentMode: .default, options: options) { image, _ in
            if let image = image {
                thumnail = image
            }
        }
        return thumnail
    }
}
