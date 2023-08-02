//
//  DetailViewController.swift
//  PhotoPicker_Example
//
//  Created by 순진이 on 2023/08/02.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        setUI()
    }
}

extension DetailViewController {
    private func setUI() {
        setAttributes()
        setConstraints()
        setToolbar()
    }
    
    private func setAttributes() {
        
        
    }
    
    private func setConstraints() {
        
    }
    
    private func setToolbar() {
        navigationController?.isToolbarHidden = false
        let appearance = UIToolbarAppearance()
        appearance.backgroundColor = .black
        navigationController?.toolbar.scrollEdgeAppearance = appearance
    }
}
