//
//  ViewController.swift
//  Animation-Advanced
//
//  Created by 순진이 on 2022/08/29.
//

import UIKit

class ViewController: UIViewController {

    let redView = UIView()
    let button = UIButton(type: .system)
    var topAnchor: NSLayoutConstraint?
    var leadingAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    @objc func buttonTapped(_ sender: UIButton) {
//        animate()
        animateKeyFrame()
    }
    
    private func animateKeyFrame() {
        UIView.animateKeyframes(withDuration: 4, delay: 0, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/6, animations: {
                self.leadingAnchor?.constant = self.view.frame.width - 80
                // 상대적인(relative) startTime임! : 0.0 ~ 1.0 까지만 존재함
                // relativeDuration : 전체 시간 중에 duration. 여기서는 4초에서 0.25니까 1초임
                self.view.layoutIfNeeded()
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1/6, relativeDuration: 2/6) {
                self.topAnchor?.constant = self.view.frame.height - 140
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 3/6, relativeDuration: 1/6) {
                self.leadingAnchor?.constant = 20
                self.view.layoutIfNeeded()
            }
            
            UIView.addKeyframe(withRelativeStartTime: 4/6, relativeDuration: 2/6) {
                self.topAnchor?.constant = 80
                self.view.layoutIfNeeded()
            }
            
            
        })
    }
    
    private func animate() {
        UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
            self.leadingAnchor?.constant = self.view.frame.width - 80
            // 레드뷰의 넓이가 60이니까 80만큼 -하면 끝이 20만큼 남을 거임
            self.view.layoutIfNeeded()
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                self.topAnchor?.constant = self.view.frame.height - 140
                self.view.layoutIfNeeded()
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                    self.leadingAnchor?.constant = 20
                    self.view.layoutIfNeeded()
                }, completion: { _ in
                    UIView.animate(withDuration: 1.0, delay: 0, options: [], animations: {
                        self.topAnchor?.constant = 80
                        self.view.layoutIfNeeded()
                    }, completion: nil)
                })
            })
        })
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
        button.setTitle("button", for: .normal)
    }
    
    final private func addTarget() {
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    final private func setConstraints() {
        [redView, button].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        topAnchor = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        topAnchor?.isActive = true
        leadingAnchor = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        leadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            
            redView.widthAnchor.constraint(equalToConstant: 60),
            redView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
