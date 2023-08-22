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
        print("")
    }
    
    
    func registerObserver() {
        PHPhotoLibrary.shared().register(self)
    }
    
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//        DispatchQueue.main.async {
//            if let albumChanges = changeInstance.changeDetails(for: albums) {
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
//    }
    
    
}
