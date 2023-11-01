//
//  UIButton+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import UIKit

extension UIButton {
    /**
     백그라운드 이미지를 컬러처럼 보이게 설정합니다.
     
     - Parameters:
       - color: 설정할 배경색. `UIColor` 객체입니다.
       - state: 설정할 상태 (`UIControl.State`)입니다.
     Tag: #Button, #Background, #Image
     */
    public func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(backgroundImage, for: state)
    }
    
}
