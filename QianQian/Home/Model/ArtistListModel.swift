//
//  SingerListModel.swift
//  QianQian
//
//  Created by 李博 on 2021/5/25.
//

import UIKit
import HandyJSON

struct artist_info: HandyJSON {
    var name: String?
    var artistCode: String?
    var pic: String?
    var isFavorite: Int?
    var favoriteCount: Int?
}

struct artist_data: HandyJSON {
    var total: Int?
    var haveMore: Int?
    var recommend: [artist_info]?
    var result: [artist_info]?
}

