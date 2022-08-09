//
//  ViewController.swift
//  Udemy_Bankey
//
//  Created by 순진이 on 2022/08/09.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }


}

//MARK: -UI
extension LoginViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        
    }
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
            
            
        ])
    }
}
