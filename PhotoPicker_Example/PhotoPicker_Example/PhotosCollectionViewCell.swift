//
//  PhotosCollectionViewCell.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/31.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: AlbumCollectionViewCell.self)
    var imageView: UIImageView = UIImageView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {

        imageView.clipsToBounds = true
        setConstraints()
        setAttributes()
    }
    
    private func setConstraints() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    private func setAttributes() {
        imageView.contentMode = .scaleAspectFill
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.alpha = 1.0
    }
}
