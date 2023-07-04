//
//  ViewController.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/03.
//

import UIKit

class ViewController: UIViewController {

    private let albumCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
}

extension ViewController {
    private func setUI() {
        setConstraints()
        setAttributes()
        
        //configureCollectionView()
        configureDataSource()
        updateData()
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: albumCollectionView, cellProvider: { collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.identifier, for: indexPath) as! AlbumCollectionViewCell
            cell.title.text = item.title
            return cell
        })
    }
    
    private func updateData() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        let section = Section(title: "Section 1")
        let items = [Item(id: 1, title: "Item 1", count: 1), Item(id: 2, title: "Item 2", count: 2), Item(id: 3, title: "Item 3", count: 3)]
        snapShot.appendSections([section])
        snapShot.appendItems(items, toSection: section)
        
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    
    private func configureCollectionView() {
        albumCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func setAttributes() {
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
    let id: Int
    let title: String
    let count: Int
}
