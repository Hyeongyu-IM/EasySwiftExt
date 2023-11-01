//
//  Double+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation

extension Double {
    /**
     소수점 이하의 0을 제거한 문자열로 변환합니다.
     
     - Returns: 소수점 이하의 0을 제거한 문자열
     Tag: #소수점
     */
    public func forTrailingZero() -> String {
        let removeZero = String(format: "%g", self)
        return removeZero
    }
}
