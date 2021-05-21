//
//  Global.swift
//  QianQian
//
//  Created by 李博 on 2021/4/7.
//

import UIKit
@_exported import SnapKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

// tabbar高度
let tabBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height > 20 ? 83 : 49

// 底部播放栏高度
let audioBottomHeight: CGFloat = 50

// 判断刘海屏
var isNotchScreen: Bool? {
    return UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
}

var rootVC: TabBarController? {
    let appDelegate = UIApplication.shared.delegate
    let window = appDelegate?.window as? UIWindow
    let tabBarVC = window?.rootViewController as? TabBarController
    return tabBarVC
}

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}


