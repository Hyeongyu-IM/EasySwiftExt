//
//  UIApplication+Extension.swift
//  bbarge
//
//  Created by 정석원 on 2023/04/28.
//

import UIKit

/**
 `UIApplication`의 확장으로, 현재의 keyWindow를 반환하는 기능을 제공합니다.
 Tag: #UIWindow, #높이, #넓이,
 */
extension UIApplication {
    
    /**
     현재의 keyWindow를 반환합니다.
     
     - Returns: 현재의 keyWindow. `UIWindow` 객체 또는 `nil`을 반환할 수 있습니다.
     */

    var keyWindow : UIWindow? {
        return self.connectedScenes
                 .filter { $0.activationState == .foregroundActive }
                 .compactMap { $0 as? UIWindowScene }.first?.windows
                 .filter({ $0.isKeyWindow}).first
    }
}
