//
//  SingerCell.swift
//  QianQian
//
//  Created by 李博 on 2021/5/26.
//

import UIKit

class SingerCell: UITableViewCell {
    
    lazy var headerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shouldRasterize = true // 开启光栅化
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        return nameLabel
    }()
    
    var artistModel: artist_info? {
        didSet {
            let url = URL(string: artistModel?.pic ?? "")
            headerImage.kf.setImage(with: url)
            nameLabel.text = artistModel?.name ?? ""
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(headerImage)
        headerImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(30)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(headerImage.snp.right).offset(30)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
