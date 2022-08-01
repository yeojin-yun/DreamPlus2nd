//
//  CustomTableViewCell.swift
//  Type Casting
//
//  Created by 순진이 on 2022/08/01.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    let myTitle = UILabel()
    let subTitle = UILabel()
    let myImageView = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(myTitle)
        contentView.addSubview(subTitle)
        contentView.addSubview(myImageView)
        
        myTitle.frame = CGRect(x: 12, y: 7, width: 0, height: 0)
        subTitle.frame = CGRect(x: 12, y: 27, width: 0, height: 0)
        subTitle.font = UIFont.systemFont(ofSize: 13)
        myImageView.frame = CGRect(x: contentView.frame.maxX - 50, y: contentView.frame.midY - 12, width: 80, height: 24)
        
        myImageView.image = UIImage(named: "4Stars")
        myImageView.contentMode = .scaleAspectFit
    }
    
    // 스토리보드에서 연결되는 부분
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
