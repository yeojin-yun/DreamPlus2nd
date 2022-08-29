//
//  ViewController.swift
//  Property-Animator
//
//  Created by 순진이 on 2022/08/29.
//

import UIKit

class ViewController: UIViewController {
    
    enum Button: String, CaseIterable {
        case start
        case pause
        case stop
    }
    
    private let redView = UIView()
    private var stackView = UIStackView()
    
    private var animator: UIViewPropertyAnimator?
    
    private var topAnchor: NSLayoutConstraint?
    private var leadingAnchor: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case Button.start.rawValue:
            startAnimation()
        case Button.pause.rawValue:
            pauseAnimation()
        case Button.stop.rawValue:
            stopAnimation()
        default:
            fatalError()
        }
    }
    
    private func startAnimation() {
        if animator == nil {
            animator = UIViewPropertyAnimator(duration: 4, timingParameters: UICubicTimingParameters())
            animator?.addAnimations {
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
        }
        animator?.startAnimation()
    }
    
    private func pauseAnimation() {
        // 잠시 멈춤. 다시 시작할 수 있음
        animator?.pauseAnimation()
    }
    
    private func stopAnimation() {
        // 애니메이션 완전 끝
        animator?.stopAnimation(false)
        animator?.finishAnimation(at: .current)
        animator = nil
        topAnchor?.constant = 80
        leadingAnchor?.constant = 20
        view.setNeedsLayout()
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
        
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        [redView, stackView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        Button.allCases.forEach {
            let button = UIButton(type: .system)
            stackView.addArrangedSubview(button)
            button.setTitle($0.rawValue, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
        
        topAnchor = redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
        topAnchor?.isActive = true
        leadingAnchor = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        leadingAnchor?.isActive = true
        
        NSLayoutConstraint.activate([
            redView.widthAnchor.constraint(equalToConstant: 60),
            redView.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            stackView.widthAnchor.constraint(equalToConstant: view.frame.width - 40)
        ])
    }
}

