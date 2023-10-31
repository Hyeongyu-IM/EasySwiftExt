//
//  NSObject+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation

extension NSObject {
    ///클래스 이름 가져오기
    ///Tag: #Class, #name
    var theClassName: String {
        return NSStringFromClass(type(of: self))
    }
}
