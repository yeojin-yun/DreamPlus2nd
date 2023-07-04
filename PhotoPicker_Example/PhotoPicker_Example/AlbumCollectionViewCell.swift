//
//  AlbumCollectionViewCell.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/04.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: AlbumCollectionViewCell.self)
    
    let title: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        contentView.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
