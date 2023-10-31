//
//  CGFloat+Extension.swift
//  bbarge
//
//  Created by 정석원 on 2023/05/26.
//  Copyright © 2023 com.leisure. All rights reserved.
//

import UIKit

extension CGFloat {
    /**
     화면의 가로 너비를 나타내는 CGFloat 값입니다.
     Tag: #화면, #가로, #width, #넓이
     */
    static var screenWidth: CGFloat = UIScreen.main.bounds.width
    
    /**
     화면의 세로 높이를 나타내는 CGFloat 값입니다.
     Tag: #화면, #세로, #height, #높이
     */
    static var screenHeight: CGFloat = UIScreen.main.bounds.height
}

extension CGFloat {
    /**
     아래쪽 안전 영역의 높이를 나타내는 CGFloat 값입니다.
     Tag: #화면, #높이, #안전역역, #safeArea
     */
    static var bottomSafeAreaHeight: Self {
        if let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom {
            return bottom
        } else {
            return 0
        }
    }
    
    static var topSafeAreaHeight: Self {
        if let top = UIApplication.shared.keyWindow?.safeAreaInsets.top {
            return top
        } else {
            return 0
        }
    }
    
}
