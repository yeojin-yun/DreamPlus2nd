//
//  ViewController.swift
//  InfiniteScrollView
//
//  Created by 순진이 on 2022/09/20.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let colors: [UIColor] = [.yellow, .red, .green, .blue, .purple, .yellow, .red, .green]
    private var cellWidth: CGFloat = 0
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        flowLayout()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }


}

//MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        performInfiniteScroll(scrollView: scrollView)
    }
    
    func performInfiniteScroll(scrollView: UIScrollView) {
        guard colors.count > 1 else { return }
        
        let currentPage = scrollView.contentOffset.x
        print("🟢currentPage: \(currentPage)")
        let firstPage = cellWidth
        let fakeFirstPage = cellWidth * CGFloat(colors.count - 2)
        print("firstPage: \(firstPage)")
        print("fakeFirstPage: \(fakeFirstPage)")
        let lastPage = cellWidth * CGFloat(colors.count - 3)
        let fakeLastPage: CGFloat = 0
        print("lastPage: \(lastPage)")
        print("fakeLastPage: \(fakeLastPage)")
        if currentPage == fakeFirstPage {
            // 만약 현재 첫 번째 페이지(=red)라면?
            scrollView.contentOffset.x = firstPage
        } else if currentPage == fakeLastPage {
            scrollView.contentOffset.x = lastPage
        }
        
    }
}

//MARK: -UI
extension ViewController {
    final private func configureUI() {
        flowLayout()
        setConstraints()
    }
    
    final private func flowLayout() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { fatalError() }
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let left: CGFloat = colors.count > 1 ? -20 : 0
        let right: CGFloat = colors.count > 1 ? 20 : 0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        cellWidth = width
        collectionView.contentOffset.x = width // 시작점을 2번째(red)로 바꾸는 코드
    }
    
    final private func setConstraints() {
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .black
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionView.heightAnchor.constraint(equalTo: collectionView.widthAnchor, multiplier: 1)
        ])
    }
}

