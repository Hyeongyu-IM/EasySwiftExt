//
//  UIScrollView+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import UIKit

public extension UIScrollView {
    ///width를 가져와서 현재가 몇페이지 인지 계산
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.7 * self.frame.size.width)) / self.frame.width)
    }
}
