//
//  CustomTableViewCell.swift
//  Xib-Starter
//
//  Created by 순진이 on 2022/12/12.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CustomTableViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // viewDidLoad와 비슷한 역할
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
