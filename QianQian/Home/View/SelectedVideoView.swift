//
//  SelectedVideoView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/21.
//

import UIKit

class SelectedVideoView: BaseView {

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
    
    var videoModel: HomeBannerData? {
        didSet {
            bgScrollView.contentSize = CGSize(width: (videoModel?.result?.count ?? 0) * 250, height: 0)
            titleLabel.text = videoModel?.module_name ?? ""
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
        let width = 240
        for resultModel in videoModel?.result ?? [] {
            // image
            let url = URL(string: resultModel.pic ?? "")
            let imageView = UIImageView()
            imageView.isUserInteractionEnabled = true
            imageView.kf.setImage(with: url)
            bgScrollView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.left.equalTo(width*index + 10*index)
                make.width.equalTo(width)
                make.height.equalTo(width / 2)
            }
            // title
            let title = UILabel()
            title.text = resultModel.title ?? ""
            title.font = UIFont.systemFont(ofSize: 12)
            bgScrollView.addSubview(title)
            title.snp.makeConstraints { (make) in
                make.top.equalTo(imageView.snp.bottom).offset(5)
                make.left.equalTo(imageView)
                make.right.equalTo(imageView)
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
                make.left.equalTo(imageView)
                make.right.equalTo(imageView)
                make.height.equalTo(10)
            }
            // playBtn
            let playBtn = UIButton()
            let btnImage = UIImage(named: "home_newsong_play")?.scaleImage(scaleSize: 0.5)
            playBtn.setImage(btnImage, for: .normal)
            playBtn.addTarget(self, action: #selector(playAlbum), for: .touchUpInside)
            playBtn.backgroundColor = .lightGray
            playBtn.layer.cornerRadius = 10
            playBtn.layer.masksToBounds = true
            playBtn.layer.shouldRasterize = true
            playBtn.ButtonImageLeft(2)
            if let duration = resultModel.duration {
                let time = String(duration).prefix(3)
                let minute = Int(Float(time)! / 60.0)
                let second = Int(time)! - (minute * 60)
                var secondStr = String(second)
                if second < 10 {
                    secondStr = "0" + String(second)
                }
                let realTime = String(minute) + ":" + secondStr
                playBtn.setTitle(realTime, for: .normal)
                playBtn.setTitleColor(.black, for: .normal)
                playBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            }
            imageView.addSubview(playBtn)
            playBtn.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview().offset(-10)
                make.width.equalTo(65)
                make.height.equalTo(20)
            }
            index += 1
        }
    }
    
    @objc func playAlbum() {
        
    }
    
    @objc func moreClick() {
        
    }

}
