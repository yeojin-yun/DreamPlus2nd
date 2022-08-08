//
//  GestureViewController.swift
//  Type Casting
//
//  Created by 순진이 on 2022/08/01.
//

import UIKit

class GestureViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let leftGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        leftGesture.direction = .left
        view.addGestureRecognizer(leftGesture)
        
        let rightGesture = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        rightGesture.direction = .right
        view.addGestureRecognizer(rightGesture)
    }
    
    @objc func didSwipe(_ sender: UISwipeGestureRecognizer) {
        var touchLocation = sender.location(in: view)
        switch sender.direction {
        case .left:
            print("left")
        case .right:
            print("right")
        default:
            break
        }
    }

}
