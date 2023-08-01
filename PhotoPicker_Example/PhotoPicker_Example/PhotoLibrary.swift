//
//  PhotoLibrary.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/27.
//

import UIKit
import Photos

extension PHPhotoLibrary {
    static func checkAuthorization(completion: @escaping (_ status: Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus(for: .readWrite) == .authorized {
            completion(true)
        } else {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
