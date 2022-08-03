//
//  AddPlayerViewController.swift
//  Type Casting
//
//  Created by 순진이 on 2022/08/01.
//

import UIKit

class AddPlayerViewController: UIViewController {

    
//     let들은 순서가 보장되지 않음
//     보장하기 위해 lazy var를 사용
//     let layout = UICollectionViewLayout()
//    lazy var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    lazy var cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(barButtonItemTapped(_:)))
    lazy var doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(barButtonItemTapped(_:)))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.dataSource = self
        title = "Add Player"
        
        tableView.register(AddPlayerTextFieldTableViewCell.self, forCellReuseIdentifier: AddPlayerTextFieldTableViewCell.identifier)
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.rightBarButtonItem = doneBarButtonItem
    }
    
    @objc func barButtonItemTapped(_ sender: UIBarButtonItem) {
        // lazy var를 이용해야 함
        // 함수가 불릴 때 버튼은 생성되지 않음
        switch sender {
        case cancelBarButtonItem:
            print("cancle")
        case doneBarButtonItem:
            print("don")
        default:
            break
        }
    }
}

extension AddPlayerViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "PLAYER NAME"
        }
        return nil
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddPlayerTextFieldTableViewCell.identifier, for: indexPath) as? AddPlayerTextFieldTableViewCell else { fatalError() }
        if indexPath.section == 0 {
            return cell
        } else {
            let basicCell = UITableViewCell()
            basicCell.textLabel?.text = "Game"
            basicCell.accessoryType = .disclosureIndicator
            let label = UILabel.init(frame: CGRect(x:0,y:0,width:100,height:20))
            label.text = "Detail"
            basicCell.accessoryView = label
            return basicCell
        }
    }
}
