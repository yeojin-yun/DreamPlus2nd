//
//  ViewController.swift
//  VisualFormatBasic
//
//  Created by 순진이 on 2022/10/27.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    
    let greenView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        view.addSubview(redView)
        view.addSubview(greenView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        greenView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["R": redView, "G": greenView]
        
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[R(130)]-|",
                                                         metrics: nil,
                                                         views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[R]-30-|",
                                                      metrics: nil,
                                                      views: views)
        
        var greenConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[G(30)]-|",
                                                              metrics: nil,
                                                              views: views)
        greenConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[G]-30-|",
                                                           metrics: nil,
                                                           views: views)
        
        view.addConstraints(constraints)
        view.addConstraints(greenConstraints)
    }

}

