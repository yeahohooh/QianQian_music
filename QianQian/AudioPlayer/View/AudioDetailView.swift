//
//  AudioDetailView.swift
//  QianQian
//
//  Created by 李博 on 2021/5/8.
//

import UIKit

class AudioDetailView: BaseView {
    
    private lazy var headerImageView: UIImageView = {
        let header = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight / 2))
        let path = Bundle.main.path(forResource: "Digital monster", ofType: "jpeg")
        header.image = UIImage(contentsOfFile: path!)
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0).cgColor,UIColor.black.cgColor]
        gradientLayer.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        gradientLayer.locations = [0.5,0.6]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.type = .axial
        header.layer.mask = gradientLayer
        return header
    }()
    
    private lazy var dropDownBtn: UIButton = {
        let drop = UIButton()
        drop.adjustsImageWhenHighlighted = false
        drop.setBackgroundImage(UIImage(named: "audio_drop_down"), for: .normal)
        drop.addTarget(self, action: #selector(dropDown), for: .touchUpInside)
        return drop
    }()
    
    private lazy var slider: CustomSlider = {
        let sliderView = CustomSlider()
        sliderView.setThumbImage(UIImage(named: "player_slider"), for: .normal)
        sliderView.minimumTrackTintColor = UIColor(r: 210, g: 180, b: 140)
        sliderView.addTarget(self, action: #selector(sliderValueChange(_:)), for: .valueChanged)
        return sliderView
    }()
    
    private lazy var timeLabel: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 10, weight: .light)
        lab.textColor = .white
        return lab
    }()
    
    private lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_play"), for: .normal)
        btn.addTarget(self, action: #selector(playClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var previousBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_previous"), for: .normal)
        return btn
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_next"), for: .normal)
        return btn
    }()
    
    private lazy var listMode: UIButton = {
        let btn = UIButton()
        btn.tag = 0
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "playlist_cycle"), for: .normal)
        btn.addTarget(self, action: #selector(modeChange(_:)), for: .touchUpInside)
        return btn
    }()
    
    private lazy var timerBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_timer"), for: .normal)
        return btn
    }()
    
    private lazy var downloadBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_download"), for: .normal)
        return btn
    }()
    
    private lazy var collectBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_collect"), for: .normal)
        return btn
    }()
    
    private lazy var shareBtn: UIButton = {
        let btn = UIButton()
        btn.adjustsImageWhenHighlighted = false
        btn.setBackgroundImage(UIImage(named: "player_share"), for: .normal)
        return btn
    }()
    
    // 是否显示
    var isShow: Bool = false {
        didSet {
            if isShow {
                slider.maximumValue = Float(AudioPlayer.shared.audioPlayer!.duration)
                timeLabel.text = convertSS(Float(AudioPlayer.shared.audioPlayer!.currentTime)) + "/" + convertSS(Float(AudioPlayer.shared.audioPlayer!.duration))
                if AudioPlayer.shared.audioPlayer!.isPlaying {
                    startTimer()
                    playBtn.setBackgroundImage(UIImage(named: "player_pause"), for: .normal)
                    playBtn.isSelected = true
                }
            }
        }
    }
    
    var progressTimer: Timer?

    override func setupUI() {
        backgroundColor = UIColor(r: 30, g: 42, b: 82)
        
        addSubview(headerImageView)
        
        addSubview(dropDownBtn)
        dropDownBtn.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.left.equalTo(40)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        addSubview(slider)
        slider.snp.makeConstraints { make in
            make.top.equalTo(headerImageView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(10)
        }
        
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(slider.snp.top).offset(-10)
            make.centerX.equalTo(slider.snp.left)
        }
        
        addSubview(playBtn)
        playBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(screenHeight * (3 / 4))
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        addSubview(previousBtn)
        previousBtn.snp.makeConstraints { make in
            make.centerY.equalTo(playBtn)
            make.right.equalTo(playBtn.snp.left).offset(-30)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerY.equalTo(playBtn)
            make.left.equalTo(playBtn.snp.right).offset(30)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        addSubview(listMode)
        listMode.snp.makeConstraints { make in
            make.centerY.equalTo(playBtn)
            make.right.equalTo(previousBtn.snp.left).offset(-20)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        addSubview(timerBtn)
        timerBtn.snp.makeConstraints { make in
            make.centerY.equalTo(playBtn)
            make.left.equalTo(nextBtn.snp.right).offset(20)
            make.size.equalTo(CGSize(width: 25, height: 25))
        }
        
        addSubview(collectBtn)
        collectBtn.snp.makeConstraints { make in
            make.centerX.equalTo(playBtn)
            make.top.equalTo(playBtn.snp.bottom).offset(50)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        addSubview(downloadBtn)
        downloadBtn.snp.makeConstraints { make in
            make.centerY.equalTo(collectBtn)
            make.right.equalTo(collectBtn.snp.left).offset(-40)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
        
        addSubview(shareBtn)
        shareBtn.snp.makeConstraints { make in
            make.centerY.equalTo(collectBtn)
            make.left.equalTo(collectBtn.snp.right).offset(40)
            make.size.equalTo(CGSize(width: 20, height: 20))
        }
    }
    
    func startTimer() {
        progressTimer = Timer(timeInterval: 1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        RunLoop.main.add(progressTimer!, forMode: .common)
    }
    
    @objc func updateProgress() {
        slider.value = Float(AudioPlayer.shared.audioPlayer!.currentTime)
        timeLabel.text = convertSS(Float(AudioPlayer.shared.audioPlayer!.currentTime)) + "/" + convertSS(Float(AudioPlayer.shared.audioPlayer!.duration))
        sliderValueChange(slider)
    }
    
    func removeTimer() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
    
    @objc func sliderValueChange(_ slider: UISlider) {
        let positionX = slider.value * ((Float(screenWidth) - 60) / slider.maximumValue) + 30
        timeLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(slider.snp.top).offset(-10)
            make.centerX.equalTo(positionX)
        }
    }
    
    @objc func playClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setBackgroundImage(UIImage(named: "player_pause"), for: .normal)
            AudioPlayer.shared.audioPlayer?.play()
            startTimer()
        } else {
            sender.setBackgroundImage(UIImage(named: "player_play"), for: .normal)
            AudioPlayer.shared.audioPlayer?.pause()
            removeTimer()
        }
    }
    
    @objc func modeChange(_ sender: UIButton) {
        let images = ["playlist_cycle","playlist_singleCycle","playlist_random"]
        sender.tag = sender.tag + 1
        if sender.tag == 3 {
            sender.tag = 0
        }
        sender.setBackgroundImage(UIImage(named: images[sender.tag]), for: .normal)
    }
    
    @objc func dropDown() {
        UIView.animate(withDuration: 1) { [self] in
            frame = CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight)
            isShow = false
            if AudioPlayer.shared.audioPlayer!.isPlaying {
                removeTimer()
            }
        }
    }
    
    private func convertSS(_ ss: Float) -> String {
        return "\(NSInteger(ss / 60)):" + String(format: "%.0f", ss.truncatingRemainder(dividingBy: 60))
    }

}
