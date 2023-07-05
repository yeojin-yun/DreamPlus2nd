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
        albumCollectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, environment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(60), heightDimension: .estimated(40))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 4)
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
