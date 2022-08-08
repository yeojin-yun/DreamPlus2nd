//
//  ViewController.swift
//  AutoLayout
//
//  Created by 순진이 on 2022/08/08.
//

import UIKit

protocol MyDelegate: UIView {
    func ssss()
}

class ViewController: UIViewController {
    
    let purpleView = UIView()
    let yellowView = UIView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        purpleView.backgroundColor = .purple.withAlphaComponent(0.4)
        yellowView.backgroundColor = .yellow.withAlphaComponent(0.4)
        //setUI()
//        print(purpleView.frame)
//        print(purpleView.bounds)
        setStackView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(purpleView.frame)
        print(purpleView.bounds)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(purpleView.frame)
        print(purpleView.bounds)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//                print(purpleView.frame)
//                print(purpleView.bounds)
//    }
    
    func setUI() {
        // addSubView를 가장 먼저 해줘야 함
        view.addSubview(purpleView)
        view.addSubview(yellowView)
        purpleView.translatesAutoresizingMaskIntoConstraints = false
        yellowView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 1.
//        redView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        redView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        redView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//
//
//        blueView.heightAnchor.constraint(equalToConstant: 100).isActive = true
//        blueView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//        blueView.topAnchor.constraint(equalTo: redView.bottomAnchor).isActive = true
//        blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        // 2.
        NSLayoutConstraint.activate([
            purpleView.heightAnchor.constraint(equalToConstant: 100),
            purpleView.widthAnchor.constraint(equalToConstant: 100),
            purpleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            purpleView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            yellowView.heightAnchor.constraint(equalToConstant: 100),
            yellowView.widthAnchor.constraint(equalToConstant: 100),
            yellowView.topAnchor.constraint(equalTo: purpleView.bottomAnchor),
            yellowView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
    
    func setStackView() {
        // axis, distribution, alignment, spacing
        // axis: 가로 vs 세로
        // alignment: Y축 정렬
        // distributioin: X축 정렬
        // spacing: 간격
        
        stackView.addArrangedSubview(purpleView)
        stackView.addArrangedSubview(yellowView)
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 50
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .lightGray
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 300),
            stackView.widthAnchor.constraint(equalToConstant: 200),
            
            purpleView.heightAnchor.constraint(equalToConstant: 100),
            purpleView.widthAnchor.constraint(equalToConstant: 100),
            yellowView.heightAnchor.constraint(equalToConstant: 100),
            yellowView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }

}


