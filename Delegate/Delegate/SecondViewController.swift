//
//  SecondViewController.swift
//  Delegate
//
//  Created by 순진이 on 2022/08/22.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func didDismissed(text: String)
}

class SecondViewController: UIViewController {
    
    let label = UILabel()
    
    weak var delegate: SecondViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .yellow
    }
    
    deinit {
        delegate?.didDismissed(text: "🍎2번 뷰컨에서 건너옴")
    }
}

//MARK: -UI
extension SecondViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        label.text = "나는 두 번째 뷰컨"
    }
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}

