//
//  UIButtonExtension.swift
//  QianQian
//
//  Created by 李博 on 2021/4/19.
//

import UIKit

extension UIButton {
    // 图片在上 文字在下
    func ButtonImageTop(_ space: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: -(self.titleLabel?.intrinsicContentSize.height)! - space, left: 0, bottom: 0, right: -(self.titleLabel?.intrinsicContentSize.width)!)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.currentImage?.size.width)!, bottom: -(self.currentImage?.size.height)! - space, right: 0)
    }
    // 图片在左 文字在右
    func ButtonImageLeft(_ space: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -space, bottom: 0, right: space)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: space, bottom: 0, right: -space)
    }
    // 图片在下 文字在上
    func ButtonImageBottom(_ space: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -(self.titleLabel?.intrinsicContentSize.height)! - space, right: -(self.titleLabel?.intrinsicContentSize.width)!)
        self.titleEdgeInsets = UIEdgeInsets(top: -(self.currentImage?.size.height)! - space, left: -(self.titleLabel?.intrinsicContentSize.width)!, bottom: 0, right: 0)
    }
    // 图片在右 文字在左
    func ButtonImageRight(_ space: CGFloat) {
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: (self.titleLabel?.intrinsicContentSize.width)! + space, bottom: 0, right: -(self.titleLabel?.intrinsicContentSize.width)! - space)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.currentImage?.size.width)! - space, bottom: 0, right: -(self.currentImage?.size.width)! + space)
    }
}
