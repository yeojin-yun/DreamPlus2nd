//
//  ViewController.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/03.
//

import UIKit

class ViewController: UIViewController {

    private let albumCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }


}

extension ViewController {
    private func setUI() {
        setConstraints()
        setAttributes()
    }
    
    private func setAttributes() {
        title = "앨범"
    }
    
    private func setConstraints() {
        [albumCollectionView].forEach {
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            albumCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            albumCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            albumCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            albumCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
