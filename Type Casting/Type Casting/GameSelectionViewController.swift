//
//  GameSelectionViewController.swift
//  Type Casting
//
//  Created by 순진이 on 2022/08/08.
//

import UIKit

class GameSelectionViewController: UIViewController {
    
    let tablewView = UITableView()
    let games = ["Angry Bird", "Chess", "Russian Rullet", "Spin the Bottle", "Texas Hold'em Poker", "Tic-Tac-Toe"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUI()
        tablewView.dataSource = self
        tablewView.delegate = self
        tablewView.isScrollEnabled = false
        tablewView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func setUI() {
        view.addSubview(tablewView)
        tablewView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tablewView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tablewView.topAnchor.constraint(equalTo: view.topAnchor),
            tablewView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tablewView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}


extension GameSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}

extension GameSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = games[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 13)
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
}

