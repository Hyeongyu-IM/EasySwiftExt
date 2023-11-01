//
//  Data+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//

import Foundation

extension Data {
    /**
     이 Data 인스턴스를 pretty-printed JSON 문자열로 변환합니다.
     
     - Returns: pretty-printed JSON 문자열. 변환에 실패하면 nil을 반환합니다.
     Tag: #Json 
     */
    public var prettyPrintedJSONString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
        return prettyPrintedString
    }
}
