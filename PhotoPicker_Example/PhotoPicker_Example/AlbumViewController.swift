//
//  ViewController.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/03.
//

import UIKit
import Photos

class AlbumViewController: UIViewController {
    
    private let albumCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var items: [Item] = []
    var albums: [PHAssetCollection] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
        print(#function)
        PHPhotoLibrary.checkAuthorization { status in
            if status {
                
                self.albums.removeAll()
                self.fetchCollection()
                
            } else {
                print("앨범 페치 X")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setUI()
//        registerObserver()
    }
    
    func fetchCollection() {
        let fetchResultSmart = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: .none)
        let fecthResultAlbum = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: .none)
        let total: [Void] = [fecthResultAlbum, fetchResultSmart].compactMap {
            $0.enumerateObjects { collection, _, _ in
                if collection.hasAsset() {
                    self.albums.append(collection)
                }
            }
        }
//        print("here4- \(self.albums.count)")
//        var items: [Item] = []
//        for album in albums {
//            let assets = PHAsset.fetchAssets(in: album, options: .none)
//            items.append(Item(id: album.localIdentifier ,asset: assets.firstObject!, title: album.localizedTitle!, count: assets.count))
//        }
        DispatchQueue.main.async {
            self.albumCollectionView.reloadData()
        }
    }
    
    private func updateData(_ items: [Item]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        let section = Section(title: "Section 1")
        
        snapShot.appendSections([section])
        snapShot.appendItems(items, toSection: section)
        
        dataSource.apply(snapShot, animatingDifferences: true)
        DispatchQueue.main.async {
            self.albumCollectionView.reloadData()
        }
    }
}

extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assets = PHAsset.fetchAssets(in: albums[indexPath.item], options: .none)
        let vc = PhotosViewController(assets: assets)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell() }
        let assets = PHAsset.fetchAssets(in: albums[indexPath.item], options: .none)
        cell.title.text = albums[indexPath.item].localizedTitle
        cell.count.text = String(assets.count)
        cell.imageView.image = assets.firstObject!.getImageFromAsset(size: CGSize(width: 100, height: 100))
        return cell
    }
}



extension AlbumViewController {
    private func setUI() {
        setConstraints()
        setAttributes()
        
        configureCollectionView()
//        configureDataSource()
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: albumCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as! AlbumCollectionViewCell
            cell.title.text = item.title
            cell.count.text = String(item.count)
            cell.imageView.image = item.asset.getImageFromAsset(size: CGSize(width: 100, height: 100))
            return cell
        })
    }
    

    private func configureCollectionView() {
        albumCollectionView.collectionViewLayout = createLayout()
        albumCollectionView.delegate = self
        albumCollectionView.dataSource = self
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, environment in
            //fractionalWidth, fractionalHeight : 컬렉션뷰의 비례한 크기
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension:.fractionalHeight(1.0) )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            //item을 묶은 group 사이즈에 대한 셋팅
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.25))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
            
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = CGFloat(10)
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100.0))
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            
            return section
        }
    }
    
    private func setAttributes() {
        view.backgroundColor = .white
        title = "앨범"
        
        
    }
    
    private func setConstraints() {
        [albumCollectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        albumCollectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.identifier)
        
        NSLayoutConstraint.activate([
            albumCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
            albumCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            albumCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            albumCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

struct Section: Hashable {
    let title: String
}

struct Item: Hashable {
    let id: String
    let asset: PHAsset
    let title: String
    let count: Int
}
