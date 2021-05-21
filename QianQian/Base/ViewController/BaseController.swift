//
//  BaseController.swift
//  QianQian
//
//  Created by 李博 on 2021/4/7.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setupUI()
    }
    
    func setupUI() {
        
    }
    

}
