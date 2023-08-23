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
    private var selectMode: Bool = false
    private var selectedImageArray: [UIImage] = [] {
        didSet {
            print(selectedImageArray)
        }
    }

    init(assets: PHFetchResult<PHAsset>) {
        self.assets = assets
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isToolbarHidden = true
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
        print("didSelect: \(selectMode)")
        if selectMode {
            /// 선택모드면 사진이 불투명 해져야함
            if let cell = collectionView.cellForItem(at: indexPath) as? PhotosCollectionViewCell {
                
                if cell.isSelected {
                    cell.imageView.alpha = 0.6
                    selectedImageArray.append(assets.object(at: indexPath.row).getImageFromAsset(size: UIScreen.main.bounds.size))
                } else {
                    cell.imageView.alpha = 0.0
                    selectedImageArray.remove(at: selectedImageArray.firstIndex(of: assets.object(at: indexPath.row).getImageFromAsset(size: UIScreen.main.bounds.size))!)
                }
            }
        } else {
            let image = assets.object(at: indexPath.row).getImageFromAsset(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            let vc = DetailViewController(image: image)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

extension PhotosViewController {
    @objc func selectModeTapped(_ sender: UIBarButtonItem) {
        
        selectMode.toggle()
        print("select Mode: \(selectMode)")
        photoCollectionView.reloadData()
        navigationController?.isToolbarHidden = selectMode ? false : true
        if !selectMode {
            selectedImageArray.removeAll()
        }
    }
    
    @objc func shareButtonTapped(_ sender: UIBarButtonItem) {
        let testPhoto = UIImage(named: "test.png")
        let activityViewController = UIActivityViewController(activityItems: [testPhoto], applicationActivities: nil)
        
        // iPad에서 팝오버 스타일로 표시되도록 설정 (필요한 경우)
        
        
        // 공유 작업 종료 시 동작 설정
        
        
        // UIActivityViewController 표시
        present(activityViewController, animated: true, completion: nil)
           
    }
    
    @objc func trashButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    
    @objc func infoButtonTapped(_ sender: UIBarButtonItem) {
        
    }
}

extension PhotosViewController {
    private func setUI() {
        setAttributes()
        setCollectionView()
        setConstraint()
        setToolbar()
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectModeTapped(_:)))
    }
    
    private func setToolbar() {
        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = .white
        navigationController?.toolbar.scrollEdgeAppearance = appearance
        navigationController?.toolbar.compactScrollEdgeAppearance = appearance
        navigationController?.toolbar.standardAppearance = appearance
        
        var shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped(_:)))
        var textButton = UIBarButtonItem(title: "항목 선택", style: .done, target: self, action: nil)
        textButton.isEnabled = false
        
        
        var trashButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashButtonTapped(_:)))
        var infoButton = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoButtonTapped(_:)))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.toolbarItems = [shareButton, flexibleSpace, textButton, flexibleSpace, infoButton, trashButton]
    }
}
