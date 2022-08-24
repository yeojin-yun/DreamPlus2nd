//
//  ViewController.swift
//  UserDefaults
//
//  Created by 순진이 on 2022/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    let label = UILabel()
    let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

extension ViewController {
    func save(text: String) {
        // 저장하는 함수
        UserDefaults.standard.set(text, forKey: "Key")
    }
    
    func load() -> String {
        // 불러오는 함수
        guard let safeText = UserDefaults.standard.string(forKey: "Key") else { return "Blank" }
        return safeText
//        guard let object = UserDefaults.standard.object(forKey: "Object") as? String else { return } -> Object는 Any 타입이기 때문에 ⭐️타입 캐스팅⭐️이 필요함
        
    }
}

//MARK: -UI
extension ViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        label.text = self.load()
        button.setTitle("button", for: .normal)
    }
    
    final private func addTarget() {
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "", message: "텍스트를 입력하세요.", preferredStyle: .alert)
        alertController.addTextField()
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            guard let alertText = alertController.textFields?.first?.text else { return }
            self.label.text = alertText
            self.save(text: alertText)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
        
    }
    
    final private func setConstraints() {
        view.addSubview(label)
        view.addSubview(button)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 60),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

