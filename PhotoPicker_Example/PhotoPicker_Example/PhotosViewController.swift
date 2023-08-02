//
//  PhotosViewController.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/31.
//

import UIKit
import Photos

class PhotosViewController: UIViewController {
    
    var assets: PHFetchResult<PHAsset>
    private var photoCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    init(assets: PHFetchResult<PHAsset>) {
        self.assets = assets
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as? PhotosCollectionViewCell else { return UICollectionViewCell() }
        let width = UIScreen.main.bounds.width / 3
        cell.imageView.image = assets.object(at: indexPath.row).getImageFromAsset(size: CGSize(width: width, height: width))
        cell.imageView.contentMode = .scaleAspectFill
        return cell
    }
}

extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotosViewController {
    private func setUI() {
        setAttributes()
        setCollectionView()
        setConstraint()
    }
    
    private func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        photoCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let width = (Int(UIScreen.main.bounds.size.width)) / 3
        layout.itemSize = CGSize(width: width, height: width)
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
    }
    
    private func setConstraint() {
        view.addSubview(photoCollectionView)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            photoCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            photoCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            photoCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func setAttributes() {
        view.backgroundColor = .white
    }
}
