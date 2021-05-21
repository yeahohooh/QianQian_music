//
//  AudioPlayer.swift
//  QianQian
//
//  Created by 李博 on 2021/5/10.
//

import Foundation
import AVFoundation

class AudioPlayer: NSObject {
    public var audioPlayer: AVAudioPlayer?
    
    // 单例
    static let shared = AudioPlayer()
    
    private override init() {
        super.init()
        /**
         本地播放
         */
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setActive(true, options: [])
        } catch let error {
            print("Unable to active session \(error.localizedDescription)")
        }
        if (audioPlayer == nil) {
            let url = Bundle.main.url(forResource: "和田光司 (わだ こうじ)-Butter-Fly", withExtension: "mp3")
            if let url = url {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: url)
                } catch let error {
                    print("Unable to initialize player \(error.localizedDescription)")
                }
            }
            audioPlayer?.numberOfLoops = 1
            audioPlayer?.volume = 1.0
            audioPlayer?.prepareToPlay()
        }
    }
}
