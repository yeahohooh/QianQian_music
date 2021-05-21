//
//  SingerView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/21.
//

import UIKit

class SingerView: BaseView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("更多", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var bgScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    var singerModel: HomeBannerData? {
        didSet {
            bgScrollView.contentSize = CGSize(width: (singerModel?.result?.count ?? 0) * 110, height: 0)
            titleLabel.text = singerModel?.module_name ?? ""
            setupContent()
        }
    }

    override func setupUI() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        self.addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
        self.addSubview(bgScrollView)
        bgScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func setupContent() {
        var index = 0
        let width = 100
        for resultModel in singerModel?.result ?? [] {
            // image
            let url = URL(string: resultModel.pic ?? "")
            let imageView = UIImageView()
            imageView.layer.cornerRadius = CGFloat(width) / 2.0
            imageView.layer.masksToBounds = true
            imageView.layer.shouldRasterize = true // 开启光栅化
            imageView.isUserInteractionEnabled = true
            imageView.kf.setImage(with: url)
            bgScrollView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalTo(width*index + 10*index)
                make.width.equalTo(width)
                make.height.equalTo(width)
            }
            // title
            let title = UILabel()
            title.text = resultModel.name ?? ""
            title.font = UIFont.systemFont(ofSize: 12)
            title.textAlignment = .center
            bgScrollView.addSubview(title)
            title.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(5)
                make.left.equalTo(imageView)
                make.right.equalTo(imageView)
                make.height.equalTo(20)
            }
            // subTitle
            let subTitle = UILabel()
            if resultModel.favoriteCount ?? 0 >= 100000 {
                subTitle.text = "10w+人已收藏"
            } else {
                subTitle.text = "\(resultModel.favoriteCount ?? 0)" + "人已收藏"
            }
            subTitle.font = UIFont.systemFont(ofSize: 10, weight: .thin)
            subTitle.textAlignment = .center
            bgScrollView.addSubview(subTitle)
            subTitle.snp.makeConstraints { (make) in
                make.top.equalTo(title.snp.bottom).offset(5)
                make.left.equalTo(imageView)
                make.right.equalTo(imageView)
                make.height.equalTo(10)
            }
            // collectBtn
            let collectBtn = UIButton()
            collectBtn.layer.shouldRasterize = true // 开启光栅化
            collectBtn.layer.cornerRadius = 10
            collectBtn.layer.masksToBounds = true
            collectBtn.layer.borderColor = UIColor(r: 210, g: 180, b: 140).cgColor
            collectBtn.layer.borderWidth = 1
            collectBtn.setTitle("收藏", for: .normal)
            collectBtn.setTitleColor(UIColor(r: 210, g: 180, b: 140), for: .normal)
            collectBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            collectBtn.addTarget(self, action: #selector(collectBtnClick), for: .touchUpInside)
            bgScrollView.addSubview(collectBtn)
            collectBtn.snp.makeConstraints { (make) in
                make.top.equalTo(subTitle.snp.bottom).offset(8)
                make.centerX.equalTo(imageView)
                make.width.equalTo(55)
                make.height.equalTo(20)
            }
            index += 1
        }
    }
    
    @objc func moreClick() {
        
    }
    
    @objc func collectBtnClick() {
        
    }

}
