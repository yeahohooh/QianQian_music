//
//  SingerAreaCell.swift
//  QianQian
//
//  Created by 李博 on 2021/5/26.
//

import UIKit

class SingerAreaCell: UITableViewCell {
    
    lazy var areaView: UIScrollView = {
        let area = UIScrollView()
        area.showsVerticalScrollIndicator = false
        area.showsHorizontalScrollIndicator = false
        return area
    }()
    
    lazy var typeView: UIScrollView = {
        let type = UIScrollView()
        type.showsVerticalScrollIndicator = false
        type.showsHorizontalScrollIndicator = false
        return type
    }()
    
    var areaSelectBtn: UIButton = UIButton()
    var typeSelectBtn: UIButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.addSubview(areaView)
        areaView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        contentView.addSubview(typeView)
        typeView.snp.makeConstraints { make in
            make.top.equalTo(areaView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        let areas = ["全部","内地","港台","欧美","韩国","日本","其他"]
        setupArea(titles: areas, superView: areaView, isArea: true)
        
        let types = ["全部","男","女","组合","乐队"]
        setupArea(titles: types, superView: typeView, isArea: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupArea(titles: Array<String>, superView: UIScrollView, isArea: Bool) {
        for index in 0..<titles.count {
            let areaBtn = UIButton()
            if index == 0 {
                areaBtn.isSelected = true
            }
            if areaBtn.isSelected {
                areaBtn.backgroundColor = UIColor(r: 210, g: 180, b: 140)
                areaBtn.setTitleColor(.white, for: .normal)
                if isArea {
                    areaSelectBtn = areaBtn
                } else {
                    typeSelectBtn = areaBtn
                }
            } else {
                areaBtn.backgroundColor = UIColor(r: 245, g: 245, b: 245)
                areaBtn.setTitleColor(.black, for: .normal)
            }
            areaBtn.layer.shouldRasterize = true // 开启光栅化
            areaBtn.layer.cornerRadius = 12
            areaBtn.layer.masksToBounds = true
            areaBtn.setTitle(titles[index], for: .normal)
            areaBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            if isArea {
                areaBtn.addTarget(self, action: #selector(areaBtnClick(_:)), for: .touchUpInside)
            } else {
                areaBtn.addTarget(self, action: #selector(typeBtnClick(_:)), for: .touchUpInside)
            }
            
            superView.addSubview(areaBtn)
            areaBtn.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview()
                make.left.equalTo(index*65 + index*15 + 20)
                make.width.equalTo(65)
                make.height.equalTo(25)
            }
            if index == titles.count - 1 {
                superview?.layoutIfNeeded()
                superView.contentSize = CGSize(width: areaBtn.frame.maxX + 10, height: 0)
            }
        }
    }
    
    @objc func areaBtnClick(_ sender: UIButton) {
        sender.isSelected = true
        sender.backgroundColor = UIColor(r: 210, g: 180, b: 140)
        sender.setTitleColor(.white, for: .normal)
        areaSelectBtn.isSelected = false
        areaSelectBtn.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        areaSelectBtn.setTitleColor(.black, for: .normal)
        areaSelectBtn = sender
    }
    
    @objc func typeBtnClick(_ sender: UIButton) {
        sender.isSelected = true
        sender.backgroundColor = UIColor(r: 210, g: 180, b: 140)
        sender.setTitleColor(.white, for: .normal)
        typeSelectBtn.isSelected = false
        typeSelectBtn.backgroundColor = UIColor(r: 245, g: 245, b: 245)
        typeSelectBtn.setTitleColor(.black, for: .normal)
        typeSelectBtn = sender
    }

}
