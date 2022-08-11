//
//  ViewController.swift
//  Udemy_Bankey
//
//  Created by 순진이 on 2022/08/09.
//

import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }


}

extension LoginViewController {
    @objc func signInButtonTapped(_ sender: UIButton) {
        
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
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: .normal)
        
    }
    final private func addTarget() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .primaryActionTriggered)
    }
    

    
    final private func setConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
            
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 15)
        ])
    }
}
