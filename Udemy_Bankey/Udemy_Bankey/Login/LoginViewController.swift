//
//  ViewController.swift
//  Udemy_Bankey
//
//  Created by 순진이 on 2022/08/09.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func didLogin()
}

protocol LogoutDelegate: AnyObject {
    func didLogout()
}

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    var password: String? {
        return loginView.passwordTextField.text
    }
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController {
    @objc func signInButtonTapped(_ sender: UIButton) {
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login() {
        guard let username = username, let password = password else {
            assertionFailure("Username / password should never be nil")
            return
        }
        
        if username.isEmpty || password.isEmpty {
            configureView(withMessage: "Username / password should never be blank")
        }
        
        if username == "" && password == "" {
            signInButton.configuration?.showsActivityIndicator = true
            delegate?.didLogin()
        } else {
            configureView(withMessage: "Incorrect username/password")
        }
    }
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
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
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.text = "Error failure"
        errorMessageLabel.isHidden = false
    }
    
    final private func addTarget() {
        signInButton.addTarget(self, action: #selector(signInButtonTapped(_:)), for: .primaryActionTriggered)
    }

    final private func setConstraints() {
        loginView.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: loginView.centerYAnchor),
            loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2),
            
            signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
            signInButton.topAnchor.constraint(equalTo: loginView.bottomAnchor, constant: 15),
            
            errorMessageLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20),
            errorMessageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
