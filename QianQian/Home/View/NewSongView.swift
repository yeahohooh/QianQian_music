//
//  NewSongView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/21.
//

import UIKit

class NewSongView: BaseView {
    
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
    
    var newSongModel: HomeBannerData? {
        didSet {
            if let count = newSongModel?.result?.count {
                bgScrollView.contentSize = CGSize(width: Int(count / 3) * Int(screenWidth - 40), height: 0)
            }
            titleLabel.text = newSongModel?.module_name ?? ""
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
        let width = 50
        let height = 55
        for resultModel in newSongModel?.result ?? [] {
            // image
            let url = URL(string: resultModel.pic ?? "")
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.kf.setImage(with: url)
            bgScrollView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalTo(height*(index % 3) + 10*(index % 3))
                make.left.equalTo(width*(Int(index / 3)) + (Int(screenWidth) - 100)*(Int(index / 3)))
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
            // title
            let title = UILabel()
            title.text = resultModel.title ?? ""
            title.font = UIFont.systemFont(ofSize: 12)
            bgScrollView.addSubview(title)
            title.snp.makeConstraints { (make) in
                make.centerY.equalTo(imageView).offset(-10)
                make.left.equalTo(imageView.snp.right).offset(10)
                make.width.equalTo(screenWidth - 180)
                make.height.equalTo(20)
            }
            // subTitle
            let subTitle = UILabel()
            var singerNames: String = ""
            if let artists = resultModel.artist {
                for i in 0..<artists.count {
                    let art = artists[i]
                    if i > 0 {
                        singerNames += (" / " + (art.name ?? ""))
                    } else {
                        singerNames = art.name ?? ""
                    }
                }
            }
            subTitle.text = singerNames
            subTitle.font = UIFont.systemFont(ofSize: 10, weight: .thin)
            bgScrollView.addSubview(subTitle)
            subTitle.snp.makeConstraints { (make) in
                make.top.equalTo(title.snp.bottom).offset(2)
                make.left.equalTo(title)
                make.width.equalTo(title)
                make.height.equalTo(10)
            }
            // playBtn
            let playBtn = UIButton()
            playBtn.setBackgroundImage(UIImage(named: "home_newsong_play"), for: .normal)
            playBtn.addTarget(self, action: #selector(playAlbum), for: .touchUpInside)
            bgScrollView.addSubview(playBtn)
            playBtn.snp.makeConstraints { (make) in
                make.centerY.equalTo(imageView)
                make.left.equalTo(title.snp.right).offset(20)
                make.width.height.equalTo(15)
            }
            index += 1
        }
    }
    
    @objc func moreClick() {
        
    }
    
    @objc func playAlbum() {
        
    }

}
