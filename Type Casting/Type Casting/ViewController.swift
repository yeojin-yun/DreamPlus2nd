//
//  ViewController.swift
//  Type Casting
//
//  Created by 순진이 on 2022/08/01.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
    
    let titles = ["Bill Evans", "Oscar Peterson", "Dave Brubeck"]
    let subtitles = ["Tic-Tac-Toe", "Spin the Bottle", "Taxas Hold'em Pocker"]
    let stars = ["4Stars", "5Stars", "2Stars"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell") // cell 등록
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(barButtonTapped(_:)))
    }
    
    @objc func barButtonTapped(_ sender: UIBarButtonItem) {
//        print(#function)
        let detailVC = UINavigationController(rootViewController: AddPlayerViewController())
        present(detailVC, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.myTitle.text = titles[indexPath.row]
        cell.subTitle.text = subtitles[indexPath.row]
        cell.myImageView.image = UIImage(named: stars[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        cell.myTitle.sizeToFit()
        cell.subTitle.sizeToFit()
        return cell
    }
}
