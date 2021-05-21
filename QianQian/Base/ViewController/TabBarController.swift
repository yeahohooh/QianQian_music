//
//  TabBarController.swift
//  QianQian
//
//  Created by 李博 on 2021/4/6.
//

import UIKit

class TabBarController: UITabBarController {
    
    // 底部的播放条
    public lazy var audioBottom: AudioBottomView = {
        let bottom = AudioBottomView(frame: CGRect(x: 0, y: screenHeight - audioBottomHeight - CGFloat(tabBarHeight), width: screenWidth, height: audioBottomHeight))
        // 上边阴影
        bottom.layer.shadowColor = UIColor.lightGray.cgColor
        bottom.layer.shadowOffset = CGSize(width: 0, height: 0)
        bottom.layer.shadowOpacity = 0.5
        bottom.layer.shadowRadius = 3
        let shadowRect = CGRect(x: 0, y: 0, width: screenWidth, height: bottom.layer.shadowRadius)
        let path = UIBezierPath(rect: shadowRect)
        bottom.layer.shadowPath = path.cgPath
        
        return bottom
    }()
    
    // 歌曲播放详情页
    public lazy var audioDetail: AudioDetailView = {
        let audio = AudioDetailView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: screenHeight))
        return audio
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // 隐藏tabbar顶部黑线
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        // tabbar背景白色
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
//        UITabBar.appearance().backgroundColor = .white
//        UITabBar.appearance().isTranslucent = false
        // 首页
        let home = HomeController()
        addChildController(home, title: "首页", image: "home", selectedImage: "home")
        
        // 我的
        let mine = MineController()
        addChildController(mine, title: "我的", image: "mine", selectedImage: "mine")
        
        view.addSubview(audioBottom)
        view.addSubview(audioDetail)
    }
    
    func addChildController(_ controller: UIViewController, title: String, image: String, selectedImage: String) -> Void {
        controller.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: selectedImage)?.withRenderingMode(.automatic))
//        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        addChild(NavigationController(rootViewController: controller))
    }

}
