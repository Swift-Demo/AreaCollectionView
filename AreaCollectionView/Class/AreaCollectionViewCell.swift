//
//  AreaCollectionViewCell.swift
//  AreaCollectionView
//
//  Created by os on 2019/11/11.
//  Copyright © 2019 os. All rights reserved.
//

import UIKit

class AreaCollectionViewCell: UICollectionViewCell {
    var label = UILabel()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews(){
        label.frame = CGRect(x: 0, y: 0, width: 72, height: 32)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = UIColor(red: 212/255.0, green: 213/255.0, blue: 220/255.0, alpha: 1.0)
        self.contentView.addSubview(label)
    }
}
