//
//  HomeModel.swift
//  QianQian
//
//  Created by 李博 on 2021/4/7.
//

import Foundation
import HandyJSON

struct AlbumArtist: HandyJSON {
    var artistCode: String?
    var birthday: String?
    var gender: String?
    var name: String?
    var artistType: Int?
    var artistTypeName: String?
    var pic: String?
    var region: String?
}

struct HomeBannerDataResult: HandyJSON {
    // banner1
    var pic: String?
    var title: String?
    var jumpType: String?
    var scenesName: String?
    var scenesCode: String?
    var scenes: String?
    var jumpLinkOutput: String?
    var sort: String?
    var showStartDate: String?
    var showEndDate: String?
    // banner2
    var module: String?
    var name: String?
    // banner3 最新专辑
    var artist: [AlbumArtist]?
    // banner4 推荐歌单
    var trackCount: Int?
    // banner5 流派
    var categoryId: Int?
    var categoryName: String?
    // banner6 推荐歌手
    var favoriteCount: Int?
    // banner7 推荐视频
    var duration: Int?
}

struct HomeBannerData: HandyJSON {
    var type: String?
    var module_name: String?
    var module_nums: Int?
    var total: Int?
    var haveMore: Int?
    var result: [HomeBannerDataResult]?
}

struct ResponseData<T>: HandyJSON {
    var state: Bool?
    var errno: Int?
    var errmsg: String?
    var elapsed_time: String?
    var data: T?
    
}

