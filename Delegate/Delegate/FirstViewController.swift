//
//  ViewController.swift
//  Delegate
//
//  Created by 순진이 on 2022/08/22.
//

import UIKit

class FirstViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
}

extension FirstViewController: SecondViewControllerDelegate {
    func didDismissed(text: String) {
        label.text = text
    }
}
//MARK: -UI
extension FirstViewController {
    final private func configureUI() {
        setAttributes()
        setConstraints()
    }
    
    final private func setAttributes() {
        label.text = "나는 첫 번째 뷰컨"
        button.setTitle("2번 뷰컨으로", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let secondVC = SecondViewController()
        secondVC.delegate = self
        
        present(secondVC, animated: true)
    }
    
    final private func setConstraints() {
        view.addSubview(label)
        view.addSubview(button)
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
    }
}
