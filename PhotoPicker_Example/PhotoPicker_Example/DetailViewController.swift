//
//  DetailViewController.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/08/02.
//

import UIKit
import Photos

class DetailViewController: UIViewController {
    
    let asset: PHAsset
    var isFavorite: Bool = false
    
    lazy var shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped(_:)))
    lazy var favoriteButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: self, action: #selector(favoriteButtonTapped(_:)))
    lazy var infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonTapped(_:)))
    lazy var trashButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashButtonTapped(_:)))
    
    var imageView: UIImageView = UIImageView()
    
    init(asset: PHAsset) {
        print("iDetailVC - asset 확인 \(asset)")
        self.asset = asset
        let image = asset.getImageFromAsset(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        imageView.image = image
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

extension DetailViewController {
    @objc func shareButtonTapped(_ sender: UIButton) {
        let testPhoto = UIImage(named: "test.png")
        let activityViewController = UIActivityViewController(activityItems: [testPhoto], applicationActivities: nil)
        
        // iPad에서 팝오버 스타일로 표시되도록 설정 (필요한 경우)
        
        
        // 공유 작업 종료 시 동작 설정
        
        
        // UIActivityViewController 표시
        present(activityViewController, animated: true, completion: nil)
    }
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        isFavorite.toggle()
        favoriteButton.image = isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
    }
    @objc func infoButtonTapped(_ sender: UIButton) {
        print(#function)
    }
    @objc func trashButtonTapped(_ sender: UIButton) {
        print(#function)
    }
}

extension DetailViewController {
    private func setUI() {
        setAttributes()
        setConstraints()
        setToolbar()
    }
    
    private func setAttributes() {
        imageView.contentMode = .scaleAspectFit
        view.backgroundColor = .white
    }
    
    private func setConstraints() {
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setToolbar() {
        navigationController?.isToolbarHidden = false
        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = .white
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        navigationController?.toolbar.compactScrollEdgeAppearance = appearance
        navigationController?.toolbar.standardAppearance = appearance
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [shareButton, flexibleSpace, favoriteButton, flexibleSpace, infoButton, flexibleSpace, trashButton]
    }
}
