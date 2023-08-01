//
//  PHAssetCollection.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/31.
//

import Foundation
import Photos

extension PHAssetCollection {
    func hasAsset() -> Bool {
        return PHAsset.fetchAssets(in: self, options: nil).count > 0 ? true : false
    }
}
