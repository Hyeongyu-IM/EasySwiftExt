//
//  CGPoint+Extension.swift
//  bbarge
//
//  Created by Ruyha on 2023/07/10.
//  Copyright © 2023 com.leisure. All rights reserved.
//

import Foundation

extension CGPoint {
   
   enum CoordinateSide {
       case topLeft, top, topRight, right, bottomRight, bottom, bottomLeft, left
   }
   ///그라데이션 보더뷰 만들때 사용함.
   static func boderPoint(_ side: CoordinateSide) -> CGPoint {
       let x: CGFloat
       let y: CGFloat

       switch side {
       case .top:          x = 0.0; y = 1.0
       case .bottom:       x = 0.0; y = 0.0
           
       case .topLeft:      x = 0.0; y = 1.0
       case .bottomRight:  x = 1.0; y = 0.0
           
       case .topRight:     x = 1.0; y = 1.0
       case .bottomLeft:   x = 0.0; y = 0.0
           
       case .right:        x = 1.0; y = 0.0
       case .left:         x = 0.0; y = 0.0
       }
       return .init(x: x, y: y)
   }
}
