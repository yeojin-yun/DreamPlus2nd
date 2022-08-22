//
//  ViewController.swift
//  CollectionView
//
//  Created by 순진이 on 2022/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    var colors: [UIColor] = [
        .systemRed, .systemPurple, .systemBlue, .systemCyan, .systemGray, .systemMint, .systemPink, .systemBrown, .systemIndigo, .systemOrange, .systemYellow, .systemRed, .systemPurple, .systemBlue, .systemCyan, .systemGray, .systemMint, .systemPink, .systemBrown, .systemIndigo, .systemOrange, .systemYellow, .systemGreen, .systemRed
    ]
    
    let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    // 생성에 순서를 보장받을 수 없기 때문에 collectionView를 늦게 만들어 주면 됨(lazy var). 자동 완성이 안되는 걸 보면 알 수 있음.
                                               
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as? CustomCollectionViewCell else { fatalError() }
        cell.backgroundColor = colors[indexPath.item]
        cell.label.text = "\(indexPath.item)"
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // 셀의 재사용성 때문에 셀의 위치를 바꿨다고 하더라도, 다시 위로 올렸을 때 원래 배열에 따라 다시 셀이 조정되기 때문에 변화가 반영되지 않는다.
        // 옮긴 indexPath를 반영하여 배열을 변경
        let color = colors.remove(at: sourceIndexPath.item) // 배열에서 아이템을 빼서
        colors.insert(color, at: destinationIndexPath.item)
    }
}

// MARK: - UI
extension ViewController {
    final private func configureUI() {
        setAttributes()
        setFlowLayout()
        setConstraints()
        addGesture()
    }
    
    final private func addGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPressed(_:)))
        collectionView.addGestureRecognizer(gesture)
    }
    
    @objc func didLongPressed(_ sender: UILongPressGestureRecognizer) {
        let location = sender.location(in: collectionView)
        print("location:",location)
        
        
        switch sender.state {
        case .began:
            print("began")
            guard let indexPath = collectionView.indexPathForItem(at: location) else { return } //indexPath가 존재하지 않는 경우도 있음
            collectionView.beginInteractiveMovementForItem(at: indexPath)
            print("indexPath:", indexPath)
        case .changed:
            print("changed")
            collectionView.updateInteractiveMovementTargetPosition(location)
        case .ended:
            print("ended")
            collectionView.endInteractiveMovement()
        case .cancelled:
            // 전화가 오거나, 알림문자가 오거나 했을 때
            collectionView.cancelInteractiveMovement()
            print("cancelled")
        default:
            break
        }
    }
    
    final private func setAttributes() {
        
    }
    
    final private func setFlowLayout() {
        flowLayout.itemSize = CGSize(width: view.frame.width / 3.3, height: view.frame.height / 4)
        flowLayout.minimumLineSpacing = 20 // 아이템 간의 세로 거리
        flowLayout.minimumInteritemSpacing = 10 // 세로 스크롤에서 아이템 간에 가로 거리
        flowLayout.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
//        flowLayout.scrollDirection = .horizontal
    }
    
    final private func setConstraints() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


