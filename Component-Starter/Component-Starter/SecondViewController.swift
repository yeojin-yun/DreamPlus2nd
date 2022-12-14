//
//  SecondViewController.swift
//  Component-Starter
//
//  Created by ěě§ě´ on 2022/08/03.
//

import UIKit

class SecondViewController: UIViewController {
    
    let label = UILabel()
    let backButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.frame = CGRect(x: view.frame.midX - 100, y: view.frame.midY - 20, width: 200, height: 40)
        label.backgroundColor = .purple.withAlphaComponent(0.3)
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 4
        label.textAlignment = .center
        
        view.addSubview(backButton)
        backButton.setTitle("Alert", for: .normal)
        backButton.sizeToFit()
        let buttonWidth = backButton.frame.width
        backButton.frame.origin = CGPoint(x: view.frame.midX - buttonWidth / 2, y: view.frame.midY + 30)
        backButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "đ¨ę˛˝ęł đ¨", message: "ë§ě§ë§ ě°˝ěëë¤.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "ěˇ¨ě", style: .cancel)
        let confirmAction = UIAlertAction(title: "íě¸", style: .default) { _ in
            print(alert.textFields?.first?.text)
        }
        alert.addTextField()
//        alert.addTextField { textField in
//            textField.keyboardType = .numberPad
//        }
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)
        present(alert, animated: true)
    }
}
