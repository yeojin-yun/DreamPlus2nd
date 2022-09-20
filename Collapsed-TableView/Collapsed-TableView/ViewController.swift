//
//  ViewController.swift
//  Collapsed-TableView
//
//  Created by 순진이 on 2022/09/19.
//

import UIKit

class ViewController: UIViewController {
    
    let tableViewData = [
        ["1", "2", "3", "4", "5"],
        ["1", "2", "3", "4", "5"],
        ["1", "2", "3", "4", "5"],
        ["1", "2", "3", "4", "5"],
        ["1", "2", "3", "4", "5"],
    ]
    
    var hiddenSection = Set<Int>()
    
    // MARK: -Properties
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    // MARK: -Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// MARK: -UI
extension ViewController {
    final private func setUI() {
        setLayout()
        setBasics()
    }
    
    final private func setLayout() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    final private func setBasics() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hiddenSection.contains(section) ? 0 : tableViewData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var configuration = cell.defaultContentConfiguration()
        configuration.text = tableViewData[indexPath.section][indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        button.setTitle(String(section), for: .normal)
        button.backgroundColor = .systemPurple
        button.tag = section
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        return button
    }
}

extension ViewController {
    @objc func buttonTapped(_ sender: UIButton) {
        let sectionTag = sender.tag
        var indexPaths = tableViewData[sectionTag].indices.map { IndexPath(row: $0, section: sectionTag) }
        
        hiddenSection.contains(sectionTag)
        ? showSection(section: sectionTag, indexPaths: indexPaths)
        : hideSection(section: sectionTag, indexPaths: indexPaths)
    }
    
    func hideSection(section: Int, indexPaths: [IndexPath]) {
        hiddenSection.insert(section)
        tableView.deleteRows(at: indexPaths, with: .fade)
    }
    
    func showSection(section: Int, indexPaths: [IndexPath]) {
        hiddenSection.remove(section)
        tableView.insertRows(at: indexPaths, with: .fade)
    }
}
