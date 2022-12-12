//
//  ViewController.swift
//  Xib-Starter
//
//  Created by 순진이 on 2022/12/12.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //instantiateStoryboard(type: .home)
        tableView.dataSource = self
        let nib = UINib(nibName: CustomTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CustomTableViewCell.identifier
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        instantiateStoryboard(type: .home)
    }
    
    enum Storyboard: String {
        case home = "Home"
    }
    
    func instantiateStoryboard() {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeStoryboard")
        vc.view.backgroundColor = .systemRed
        present(vc, animated: true)
    }

    func instantiateStoryboard(type: Storyboard) {
        let storyboard = UIStoryboard(name: type.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: HomeViewController.identifier)
        vc.view.backgroundColor = .systemRed
        present(vc, animated: true)
    }
}

enum Storyboard: String {
    case home = "Home"
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)
        return cell
    }
}
