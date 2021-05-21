//
//  UIColorExtension.swift
//  QianQian
//
//  Created by 李博 on 2021/4/21.
//

import UIKit

extension UIColor {
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
}
