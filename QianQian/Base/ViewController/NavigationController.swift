//
//  NavigationController.swift
//  QianQian
//
//  Created by 李博 on 2021/4/6.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = .white
    }
    

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            let itemLeft = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(popViewController(animated:)))
            itemLeft.tintColor = .white
            viewController.navigationItem.leftBarButtonItem = itemLeft
            
            rootVC?.audioBottom.frame = CGRect(x: 0, y: screenHeight - audioBottomHeight, width: screenWidth, height: audioBottomHeight)
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    

}
