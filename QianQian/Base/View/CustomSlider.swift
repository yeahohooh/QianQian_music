//
//  CustomSlider.swift
//  QianQian
//
//  Created by 李博 on 2021/5/10.
//

import UIKit

class CustomSlider: UISlider {

    // 取消两边间隙
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        var newRect = rect
        newRect.origin.x -= 10
        newRect.origin.y += 1
        newRect.size.width += 20
        return super.thumbRect(forBounds: bounds, trackRect: newRect, value: value).insetBy(dx: 10, dy: 10)
    }

}
