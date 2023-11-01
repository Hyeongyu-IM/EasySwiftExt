//
//  Array+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation


extension Array {
    /**
     배열이 비어있지 않은지 여부를 나타내는 불리언 값입니다.
     Tag: #Array, #Empty
     */
    var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    /**
     인덱스에 대한 요소를 반환하되, 인덱스가 유효하지 않은 경우 기본값을 반환합니다.
     
     - Parameters:
        - index: 요소의 인덱스.
        - defaultValue: 유효하지 않은 인덱스일 경우 반환할 기본값을 제공하는 클로저.
     - Returns: 요소 또는 기본값.
     Tag: #index
     */
    public subscript(index: Int, default defaultValue: @autoclosure () -> Element) -> Element {
        guard index >= 0, index < endIndex else {
            return defaultValue()
        }
        return self[index]
    }
    
    /**
     안전한 인덱스를 사용하여 요소에 접근합니다.
     
     - Parameter safeIndex: 안전한 인덱스.
     - Returns: 인덱스에 해당하는 요소 또는 nil (인덱스가 유효하지 않은 경우).
     Tag: #index, #SafeIndex
     */
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

