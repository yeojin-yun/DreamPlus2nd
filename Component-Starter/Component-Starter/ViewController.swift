//
//  ViewController.swift
//  Component-Starter
//
//  Created by 순진이 on 2022/08/03.
//

import UIKit

class ViewController: UIViewController {
    
    let textField = UITextField()
    let button = UIButton(type: .system)
    let stepper = UIStepper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Title"
//        navigationItem.title = "New Title"
        let image = UIImage(systemName: "face.smiling")
        let imageView = UIImageView(image: image)
        navigationItem.titleView = imageView
        
        
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(stepper)
        
        textField.frame = CGRect(x: view.frame.midX - 100, y: view.frame.midY - 30, width: 200, height: 40)
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 4
        textField.delegate = self
        
        button.setTitle("Next", for: .normal)
        button.sizeToFit()
        let buttonWidth = button.frame.width
        button.frame.origin = CGPoint(x: view.frame.midX - buttonWidth / 2, y: view.frame.midY + 30)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        let stpperWidth = stepper.frame.width
        stepper.frame.origin = CGPoint(x: view.frame.midX - stpperWidth / 2 , y: view.frame.midY - 100)
        stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let secondVC = SecondViewController()
        secondVC.label.text = textField.text ?? "🤢🤢🤢"
        present(secondVC, animated: true)
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(textField.text)
        return true
        //return false -> 더 이상 입력이 되지 않음. (예를들어 글자수에 따라 더 이상 입력되지 않게 하기 위해서 사용할 수 있음)
    }
    
    
    
}

