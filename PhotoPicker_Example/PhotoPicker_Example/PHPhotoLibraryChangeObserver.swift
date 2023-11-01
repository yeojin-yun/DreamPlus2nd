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
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("------Albums Change 감시------")
//        guard let albumChanges = changeInstance.changeDetails(for: self.albums) else {
//            return
//        }
//        print("------Albums 변화있음 \(albumChanges)------")
        self.albums.compactMap { assetCollection in
            print(changeInstance.changeDetails(for: assetCollection))
        }
    }

    func registerObserver() {
        print("------Albums Observer 등록------")
        PHPhotoLibrary.shared().register(self)
    }
}

extension PhotosViewController: PHPhotoLibraryChangeObserver {
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//        print("ObserVer 작동 시작")
//    }
//
    
    func registerObserver() {
        print("-----Observer 등록------")
        PHPhotoLibrary.shared().register(self)
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("---------")
//        DispatchQueue.main.async {
//            if let albumChanges = changeInstance.changeDetails(for: self.assets) {
//
//                print(albumChanges)
//            }
            
            //            if let changes = changeInstance.changeDetails(for: fetchResult) {
            //                // Keep the new fetch result for future use.
            //                fetchResult = changes.fetchResultAfterChanges
            //                if changes.hasIncrementalChanges {
            //                    // If there are incremental diffs, animate them in the collection view.
            //                    collectionView.performBatchUpdates({
            //                        // For indexes to make sense, updates must be in this order:
            //                        // delete, insert, reload, move.
            //                        if let removed = changes.removedIndexes where removed.count > 0 {
            //                            collectionView.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
            //                        }
            //                        if let inserted = changes.insertedIndexes where inserted.count > 0 {
            //                            collectionView.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
            //                        }
            //                        if let changed = changes.changedIndexes where changed.count > 0 {
            //                            collectionView.reloadItems(at: changed.map { IndexPath(item: $0, section:0) })
            //                        }
            //                        changes.enumerateMoves { fromIndex, toIndex in
            //                            collectionView.moveItem(at: IndexPath(item: fromIndex, section: 0),
            //                                                    to: IndexPath(item: toIndex, section: 0))
            //                        }
            //                    })
            //                } else {
            //                    // Reload the collection view if incremental diffs aren't available.
            //                    collectionView.reloadData()
            //                }
            //            }
//        }
        
        guard let changes = changeInstance.changeDetails(for: self.assets) else { return }
        print("after \(changes.fetchResultAfterChanges)")
        print("before \(changes.fetchResultBeforeChanges)")
        DispatchQueue.main.async {
            self.assets = changes.fetchResultAfterChanges
            self.photoCollectionView.reloadData()
        }
        
    }
    
    
}
