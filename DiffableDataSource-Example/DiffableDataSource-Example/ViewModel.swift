//
//  ViewModel.swift
//  DiffableDataSource-Example
//
//  Created by 순진이 on 2023/01/02.
//

import UIKit
import Combine

class ViewModel {

    private var dataSource: UITableViewDiffableDataSource<SectionClass, Int>!
    //<Int, Int> -> Section과 row라고 생각해주면 됨, hasable한 값이 들어가야 함
    
    let sectionClasses = [SectionClass(name: "1"), SectionClass(name: "2")]
    var numbers = [1, 2, 3]
    var newNumbers = [4, 5, 6]
    
    func addNewDate() {
        updateSnapshot2(items: numbers + newNumbers, section: sectionClasses[1])
    }
    
    private func updateSnapshot2(items: [Int], section: SectionClass) {
        var snapshot = NSDiffableDataSourceSnapshot<SectionClass, Int>()
        snapshot.appendSections(sectionClasses)
        snapshot.appendItems(items, toSection: section)
        dataSource.apply(snapshot)
    }
    
    func setupTableView(tableView: UITableView) {
//        dataSource = UITableViewDiffableDataSource<Int, Int>(tableView: <#T##UITableView#>, cellProvider: <#T##UITableViewDiffableDataSource<Int, Int>.CellProvider##UITableViewDiffableDataSource<Int, Int>.CellProvider##(_ tableView: UITableView, _ indexPath: IndexPath, _ itemIdentifier: Int) -> UITableViewCell?#>) 이게 정석인 방법

        
        let nib = UINib(nibName: CustomTableViewCell.identifier, bundle: nil)
//        tableView.delegate = self
        tableView.register(nib, forCellReuseIdentifier: CustomTableViewCell.identifier)
        dataSource = .init(tableView: tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { fatalError() }
            cell.configure(text: String(itemIdentifier))
            return cell
        })
        updateSnapshot2(items: numbers, section: sectionClasses[0])
    }
}

//section을 직접 만들 수도 있음
struct SectionClass: Hashable {
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
