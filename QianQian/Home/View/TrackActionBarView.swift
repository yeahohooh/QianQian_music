//
//  TrackActionBarView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/26.
//

import UIKit

class TrackActionBarView: BaseView {

    private lazy var titleView: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 20)
        return title
    }()
    
    private lazy var subTitleView: UILabel = {
        let subTitle = UILabel()
        subTitle.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        return subTitle
    }()
    
    private lazy var playBtn: UIButton = {
        let play = UIButton()
        let btnImage = UIImage(named: "home_newsong_play")?.scaleImage(scaleSize: 0.5)
        play.setImage(btnImage, for: .normal)
        play.addTarget(self, action: #selector(playAll), for: .touchUpInside)
        play.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        play.setTitle("全部播放", for: .normal)
        play.setTitleColor(.black, for: .normal)
        play.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        play.layer.cornerRadius = 10
        play.layer.masksToBounds = true
        play.layer.shouldRasterize = true
        play.ButtonImageLeft(2)
        return play
    }()
    
    private lazy var collectBtn: UIButton = {
        let collect = UIButton()
        collect.setBackgroundImage(UIImage(named: "track_collect"), for: .normal)
        return collect
    }()
    
    private lazy var shareBtn: UIButton = {
        let share = UIButton()
        share.setBackgroundImage(UIImage(named: "track_share"), for: .normal)
        return share
    }()
    
    private lazy var downloadBtn: UIButton = {
        let download = UIButton()
        download.setBackgroundImage(UIImage(named: "track_download"), for: .normal)
        return download
    }()
    
    var titleStr: String? {
        didSet {
            titleView.text = titleStr
        }
    }
    
    var subTitleStr: String? {
        didSet {
            subTitleView.text = subTitleStr
        }
    }
    
    override func setupUI() {
        addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(30)
        }
        
        addSubview(subTitleView)
        subTitleView.snp.makeConstraints { (make) in
            make.top.equalTo(titleView.snp.bottom)
            make.left.right.equalTo(titleView)
            make.height.equalTo(20)
        }
        
        addSubview(playBtn)
        playBtn.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleView.snp.bottom).offset(20)
            make.left.equalTo(subTitleView)
            make.width.equalTo(85)
            make.height.equalTo(25)
        }
        
        addSubview(downloadBtn)
        downloadBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(playBtn)
            make.right.equalTo(titleView)
            make.width.height.equalTo(20)
        }
        
        addSubview(shareBtn)
        shareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(downloadBtn)
            make.right.equalTo(downloadBtn.snp.left).offset(-20)
            make.width.height.equalTo(downloadBtn)
        }
        
        addSubview(collectBtn)
        collectBtn.snp.makeConstraints { (make) in
            make.top.equalTo(downloadBtn)
            make.right.equalTo(shareBtn.snp.left).offset(-20)
            make.width.height.equalTo(downloadBtn)
        }
    }
    
    @objc func playAll() {
        
    }

}
