//
//  Bundle+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation

extension Bundle {
    /**
      앱의 현재 버전을 나타내는 문자열입니다.
     Tag: #Bundle, #app
      */
    public var appVersion: String? {
         return self.infoDictionary?["CFBundleShortVersionString"] as? String
     }
}
