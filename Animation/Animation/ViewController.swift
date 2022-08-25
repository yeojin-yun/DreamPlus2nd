//
//  ViewController.swift
//  Animation
//
//  Created by 순진이 on 2022/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    let button = UIButton(type: .system)
    let stopButton = UIButton(type: .system)
    var redViewTopAnchor: NSLayoutConstraint?
    var redViewBottomAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
        redView.backgroundColor = .red
        button.setTitle("Animation", for: .normal)
    }
    
    final private func addTarget() {
        button.addTarget(self, action: #selector(startAnimation(_:)), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(stopAnimation(_:)), for: .touchUpInside)
    }
    
    @objc func startAnimation(_ sender: UIButton) {
//        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
//            self.redViewTopAnchor?.constant = 600
//            self.view.layoutIfNeeded() // 강제로 뷰의 드로잉사이클을 호출해야만 애니메이션 효과가 보임. 그냥 같이 쓴다고 생각하면 됨.
//        }, completion: nil)
    
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.redViewBottomAnchor?.priority = .required
            self.view.layoutIfNeeded() // 강제로 뷰의 드로잉사이클을 호출해야만 애니메이션 효과가 보임
        }, completion: nil)
    }
    
    @objc func stopAnimation(_ sender: UIButton) {
//        UIViewPropertyAnimator
    }
    
    final private func setConstraints() {
        view.addSubview(redView)
        view.addSubview(button)
        view.addSubview(stopButton)
        redView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Priority : 0 ~ 1,000 (기본값 1,000 = 제일 높은 값)
//
        redViewTopAnchor = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        //redViewTopAnchor?.priority = .required // 1,000
        //redViewTopAnchor?.priority = .defaultHigh // 750
        //redViewTopAnchor?.priority = .defaultLow // 250
        redViewTopAnchor?.priority = .defaultHigh
        redViewTopAnchor?.isActive = true
        
        redViewBottomAnchor = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 600)
        redViewBottomAnchor?.priority = .defaultLow
        redViewBottomAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            redView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            redView.widthAnchor.constraint(equalToConstant: 60),
            redView.heightAnchor.constraint(equalToConstant: 60),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            
            stopButton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20),
            stopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
