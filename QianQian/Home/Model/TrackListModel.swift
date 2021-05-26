//
//  TrackListModel.swift
//  QianQian
//
//  Created by 李博 on 2021/4/23.
//

import Foundation
import HandyJSON

struct Trail_audio_info: HandyJSON {
    var start_time: String?
    var expireTime: Int = 0
    var path: String?
    var duration: String?
    var rate: Int = 0
}

struct Artist: HandyJSON {
    var name: String?
    var artistCode: String?
    var artistType: Int = 0
    var region: String?
    var artistTypeName: String?
    var gender: String?
    var pic: String?
    var birthday: String?
}

struct TrackList: HandyJSON {
    var pay_model: Int = 0
    var maxVolume: Float = 0.0
    var bizList = [String]()
    var lang: String?
    var meanVolume: Float = 0.0
//    var rateFileInfo: RateFileInfo?
    var TSID: String?
    var isPaid: Int = 0
    var albumTitle: String?
    var downTime: String?
    var allRate = [String]()
    var cpId: Int = 0
    var assetId: String?
    var id: String?
    var genre: String?
    var albumAssetCode: String?
    var title: String?
    var isrc: String?
    var duration: Int = 0
    var lyric: String?
    var _trackId: Int = 0
    var pushTime: String?
    var sort: Int = 0
    var releaseDate: String?
    var trail_audio_info: Trail_audio_info?
    var pic: String?
    var isVip: Int = 0
    var isFavorite: Int = 0
    var artist: [Artist]?
    var afReplayGain: Float = 0.0
}

struct trackListData: HandyJSON {
    var resourceType: Int = 0
    var trackCount: Int = 0
    var tagList = [String]()
    var cateList = [Int]()
    var pic: String?
    var isFavorite: Int = 0
    var addDate: String?
    var desc: String?
    var id: Int = 0
    var _score: Float = 0.0
    var trackList: [TrackList]?
    var title: String?
    var haveMore: Int = 0
}
