//
//  Int+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation

extension Int {
    
    /**
     3자리마다 콤마를 추가한 문자열로 변환합니다.
     Tag: #콤마, #.
     */
    var withComma: String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = NumberFormatter.Style.decimal
        decimalFormatter.groupingSeparator = ","
        decimalFormatter.groupingSize = 3
        return decimalFormatter.string(from: self as NSNumber)!
    }
    
    /**
     정수를 문자열로 변환합니다.
     
     - Returns: 정수를 문자열로 변환한 값
     Tag: #IntToString
     */
    func toString() -> String {
            "\(self)"
    }
}
