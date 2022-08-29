//
//  ViewController.swift
//  Udemy_Bankey
//
//  Created by 순진이 on 2022/08/23.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    let stackView = UIStackView()
    let imageView = UIImageView()
    let label = UILabel()
    
    var heroImageName: String
    var titleText: String
    
    init(heroImageName: String, titleText: String) {
        self.heroImageName = heroImageName
        self.titleText = titleText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
}

//MARK: -UI
extension OnboardingViewController {
    final private func configureUI() {
        setAttributes()
        addTarget()
        setConstraints()
    }
    
    final private func setAttributes() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = titleText
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.adjustsFontSizeToFitWidth = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: heroImageName)
    }
    
    final private func addTarget() {
        
    }
    
    final private func setConstraints() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(imageView)
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

