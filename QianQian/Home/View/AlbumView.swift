//
//  AlbumView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/19.
//

import UIKit

@objc protocol AlbumViewDelegate: NSObjectProtocol {
    @objc func didClickAlbum()
}

class AlbumView: BaseView {
    
    weak var albumDelegate: AlbumViewDelegate?
    
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
        btn.isHidden = true
        btn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var bgScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    enum AlbumType {
        case new
        case list
    }
    
    var currentAlbumType: AlbumType?
    
    var showMore: Bool = false {
        didSet {
            moreButton.isHidden = !showMore
        }
    }
    
    var albumModel: HomeBannerData? {
        didSet {
            bgScrollView.contentSize = CGSize(width: (albumModel?.result?.count ?? 0) * 130, height: 0)
            titleLabel.text = albumModel?.module_name ?? ""
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
        let width = 120
        for resultModel in albumModel?.result ?? [] {
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
                make.height.equalTo(width)
            }
            let tap = UITapGestureRecognizer(target: self, action: #selector(imageClick))
            tap.numberOfTapsRequired = 1
            tap.numberOfTouchesRequired = 1
            imageView.addGestureRecognizer(tap)
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
            if currentAlbumType == .new {
                subTitle.text = resultModel.artist?[0].name ?? ""
            } else if currentAlbumType == .list {
                subTitle.text = "\(resultModel.trackCount ?? 0)" + "首单曲"
            }
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
            playBtn.setBackgroundImage(UIImage(named: "home_album_play"), for: .normal)
            playBtn.addTarget(self, action: #selector(playAlbum), for: .touchUpInside)
            imageView.addSubview(playBtn)
            playBtn.snp.makeConstraints { (make) in
                make.right.equalToSuperview().offset(-5)
                make.bottom.equalToSuperview().offset(-5)
                make.width.height.equalTo(25)
            }
            index += 1
        }
    }
    
    @objc func playAlbum() {
        
    }
    
    @objc func moreClick() {
        
    }
    
    @objc func imageClick() {
        albumDelegate?.didClickAlbum()
    }
    
}

