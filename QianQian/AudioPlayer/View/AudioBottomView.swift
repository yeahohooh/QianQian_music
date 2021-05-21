//
//  AudioBottomView.swift
//  QianQian
//
//  Created by 李博 on 2021/4/30.
//

import UIKit
import AVFoundation

class AudioBottomView: BaseView {
    
    private lazy var songImageView: UIImageView = {
        let imageView = UIImageView()
        let path = Bundle.main.path(forResource: "Digital monster", ofType: "jpeg")
        imageView.image = UIImage(contentsOfFile: path!)
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "(わだ こうじ)-Butter-Fly-和田光司"
        title.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return title
    }()
    
    private lazy var playBtn: UIButton = {
        let play = UIButton()
        play.setBackgroundImage(UIImage(named: "audio_play"), for: .normal)
        play.addTarget(self, action: #selector(playClick(_:)), for: .touchUpInside)
        play.isSelected = false
        return play
    }()
    
    private lazy var nextBtn: UIButton = {
        let next = UIButton()
        next.setBackgroundImage(UIImage(named: "audio_next"), for: .normal)
        return next
    }()
    
    private lazy var line: UILabel = {
        let lab = UILabel()
        lab.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        return lab
    }()
    
    override func setupUI() {
        backgroundColor = .white
        addSubview(songImageView)
        songImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(songImageView.snp.right).offset(10)
            make.height.equalToSuperview()
            make.width.equalTo(200)
        }
        
        addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        addSubview(playBtn)
        playBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(nextBtn.snp.left).offset(-20)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(audioClick))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        addGestureRecognizer(tap)
    }
    
    @objc func playClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setBackgroundImage(UIImage(named: "audio_pause"), for: .normal)
            AudioPlayer.shared.audioPlayer?.play()
        } else {
            sender.setBackgroundImage(UIImage(named: "audio_play"), for: .normal)
            AudioPlayer.shared.audioPlayer?.pause()
        }
    }
    
    @objc func audioClick() {
        UIView.animate(withDuration: 1) {
            rootVC?.audioDetail.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
            rootVC?.audioDetail.isShow = true
        }
    }
}
