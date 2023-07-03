//
//  CustomView.swift
//  Xib-Starter
//
//  Created by 순진이 on 2022/12/12.
//

import UIKit

class CustomView: UIView {
    
    static let identifier = String(describing: CustomView.self)

    override init(frame: CGRect) {
        super.init(frame: frame)
        instantiateXib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
//    override class func awakeFromNib() {
//        super.awakeFromNib()
//        instantiateXib()
//    }
    
    private func instantiateXib() {
        Bundle.main.loadNibNamed(CustomView.identifier, owner: self)
        
        let nib = UINib(nibName: CustomView.identifier, bundle: nil)
        guard let customView = nib.instantiate(withOwner: self).first as? CustomView else { return }
//        guard let customView = Bundle.main.loadNibNamed(CustomView.identifier, owner: self) as? CustomView else { return } - 30과 똑같은 내용
        // Bundle = 왼쪽 리스트
        customView.frame = frame
        customView.backgroundColor = .clear
        addSubview(customView)
        backgroundColor = .yellow
    }
}
