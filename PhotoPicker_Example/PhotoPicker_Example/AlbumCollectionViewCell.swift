//
//  AlbumCollectionViewCell.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/07/04.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: AlbumCollectionViewCell.self)
    
    let imageView: UIImageView = UIImageView()
    let title: UILabel = UILabel()
    let count: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yellow
        setUI()
        setTest()
    }
    
    private func setUI() {
        [imageView, title, count].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            count.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 3),
            count.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10)
        ])
    }
    
    private func setTest() {
        imageView.backgroundColor = .systemPink
        title.text = "최근 앨범"
        count.text = "3,092"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
