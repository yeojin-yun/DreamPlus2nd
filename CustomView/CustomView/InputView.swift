//
//  InputView.swift
//  CustomView
//
//  Created by 순진이 on 2022/08/10.
//

import UIKit

class InputView: UIView {
    enum TextFieldType: String {
        case id = "아이디"
        case password = "패스워드"
    }
    
    private let inputLabel = UILabel()
    private let inputTextField = UITextField()
    
    var text: String? {
        return inputTextField.text
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        inputLabel.text = type.rawValue
        inputLabel.font = UIFont.systemFont(ofSize: 13)
        inputLabel.textColor = .gray
        
        inputTextField.borderStyle = .roundedRect
        inputTextField.keyboardType = .default
        inputTextField.autocapitalizationType = .none
        
        if type == .password {
            inputTextField.isSecureTextEntry = true
        }
        setUI()
    }
    
    func setUI() {
        addSubview(inputLabel)
        addSubview(inputTextField)
        inputLabel.translatesAutoresizingMaskIntoConstraints = false
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputLabel.topAnchor.constraint(equalTo: topAnchor),
            inputLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.topAnchor.constraint(equalTo: inputLabel.bottomAnchor, constant: 8),
            inputTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
//            inputTextField.heightAnchor.constraint(equalToConstant: 40),
            inputTextField.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
