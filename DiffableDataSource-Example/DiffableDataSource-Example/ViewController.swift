//
//  ViewController.swift
//  DiffableDataSource-Example
//
//  Created by 순진이 on 2023/01/02.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = ViewModel()
    
//    private var dataSource: UITableViewDiffableDataSource<SectionClass, Int>!
//    //<Int, Int> -> Section과 row라고 생각해주면 됨, hasable한 값이 들어가야 함
//    
    var numbers = [1, 2, 3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        viewModel.setupTableView(tableView: tableView)
//        setupTableView()
//        updateSnapshot2(items: numbers, section: sectionClasses[0])
    }
    
//    private func updateSnapshot(items: [Int], section: Section) {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
//        snapshot.appendSections(Section.allCases)
//        snapshot.appendItems([1, 2, 3], toSection: Section.first)
//        snapshot.appendItems([4, 5, 6], toSection: Section.second)
//        dataSource.apply(snapshot)
//    }
}


//enum은 hasable하기 때문에 enum을 이용하면 편하다
enum Section: CaseIterable {
    case first
    case second
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.addNewDate()
    }
}

//cellProvider
//headerView
