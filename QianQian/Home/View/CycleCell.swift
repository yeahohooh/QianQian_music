//
//  CycleCell.swift
//  QianQian
//
//  Created by 李博 on 2021/4/8.
//

import UIKit

class CycleCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = contentView.bounds
        contentView.addSubview(imageView)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
