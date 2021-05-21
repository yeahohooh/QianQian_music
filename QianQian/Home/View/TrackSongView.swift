//
//  TrackSongView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/26.
//

import UIKit

class TrackSongView: BaseView {

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var title: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return lab
    }()
    
    private lazy var name: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        return lab
    }()
    
    private lazy var vip: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        lab.text = "vip"
        lab.textColor = .white
        lab.textAlignment = .center
        lab.backgroundColor = UIColor(r: 210, g: 180, b: 140)
        return lab
    }()
    
    private lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "track_more"), for: .normal)
        btn.addTarget(self, action: #selector(moreClick), for: .touchUpInside)
        return btn
    }()
    
    var trackModel: TrackList? {
        didSet {
            let url = URL(string: trackModel?.pic ?? "")
            imageView.kf.setImage(with: url)
            title.text = trackModel?.title
            setupName()
        }
    }
    
    override func setupUI() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.width.height.equalTo(50)
        }
        
        addSubview(title)
        title.snp.makeConstraints { (make) in
            make.top.equalTo(imageView)
            make.left.equalTo(imageView.snp.right).offset(10)
            make.width.equalTo(screenWidth - 150)
            make.height.equalTo(25)
        }
        
        addSubview(rightBtn)
        rightBtn.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
    }
    
    private func setupName() {
        if trackModel?.isVip == 1 {
            addSubview(vip)
            vip.snp.makeConstraints { (make) in
                make.top.equalTo(title.snp.bottom).offset(5)
                make.left.equalTo(title)
                make.width.equalTo(20)
                make.height.equalTo(10)
            }
        }
        var singerNames: String = ""
        if let artists = trackModel?.artist {
            for i in 0..<artists.count {
                let art = artists[i]
                if i > 0 {
                    singerNames += (" / " + (art.name ?? ""))
                } else {
                    singerNames = art.name ?? ""
                }
            }
        }
        name.text = singerNames
        addSubview(name)
        name.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.equalTo(trackModel?.isVip == 1 ? vip.snp.right:imageView.snp.right).offset(10)
            make.width.equalTo(title)
            make.height.equalTo(10)
        }
    }
    
    @objc func moreClick() {
        
    }

}
