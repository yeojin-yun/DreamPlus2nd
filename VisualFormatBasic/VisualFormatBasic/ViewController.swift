//
//  ViewController.swift
//  VisualFormatBasic
//
//  Created by 순진이 on 2022/10/27.
//

import UIKit

class ViewController: UIViewController {
    
    let redView = UIView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        redView.backgroundColor = .red
        view.addSubview(redView)
        redView.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["R": redView]
        
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[R(30)]-|",
                                                         metrics: nil,
                                                         views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[R]-30-|",
                                                      metrics: nil,
                                                      views: views)
        
        view.addConstraints(constraints)
    }

}

