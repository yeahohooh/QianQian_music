//
//  UIImageExtension.swift
//  QianQian
//
//  Created by 李博 on 2021/4/19.
//

import UIKit

extension UIImage {
    // 裁剪图片
    func scaleImage(scaleSize: CGFloat) -> UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale);
       self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height));
       let reSizeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!;
       UIGraphicsEndImageContext();
       return reSizeImage;
    }
}
