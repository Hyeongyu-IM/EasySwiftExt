//
//  StringExtension.swift
//  bbarge
//
//  Created by 임현규 on 2021/06/11.
//

import UIKit

//MARK: -- Validation Check
extension String {
    /**
     문자열이 비어있는지 확인합니다.
     */
    public var isNotEmpty: Bool {
        return !self.isEmpty
    }
    
    public func convertToDate(format: DateFormat) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = .KR
        dateFormatter.locale = .KR
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    /**
     입력된 문자열이 닉네임으로 유효한지 확인합니다.
     
     - Returns: 유효한 닉네임인 경우 true를 반환합니다.
     */
    public func isNickName() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣㆍ\\s]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    /**
     입력된 문자열이 한글인지 확인합니다.
     
     - Returns: 한글인 경우 true를 반환합니다.
     */
    public func isHangul() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[가-힣ㄱ-ㅎㅏ-ㅣ\\s]$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    /**
     입력된 문자열이 전화번호 형식인지 확인합니다.
     
     - Returns: 전화번호 형식인 경우 true를 반환합니다.
     */
    public func isPhone() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^01([0|1|6|7|8|9])([0-9]{4})([0-9]{4})$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    /**
     입력된 문자열이 이메일 형식인지 확인합니다.
     - Returns: 이메일 형식인 경우 true를 반환합니다.
     */
    public func isEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
}

//MARK: -- Date
extension String {
    /**
     문자열을 정수로 변환합니다.
     
     - Returns: 변환된 정수 값.
     */
    public func toInt() -> Int {
        return Int(self) ?? 0
    }
    
    /**
     문자열을 실수로 변환합니다.
     
     - Returns: 변환된 실수 값.
     */
    public func toDouble() -> Double {
        return Double(self) ?? 0
    }
    
    /**
     전화번호 형식에 맞게 문자열을 변환합니다.
     
     - Returns: 전화번호 형식으로 변환된 문자열. 예: "010-1234-5678"
     */
    public func phoneNumber() -> String {
        let _str = self.replacingOccurrences(of: "-", with: "") // 하이픈 모두 제거
        let arr = Array(_str)
        if arr.count > 11 {
            if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                return modString
            }
        } else if arr.count > 3 && arr.count <= 11 {
            let prefix = String(format: "%@%@", String(arr[0]), String(arr[1]))
            if prefix == "02" { // 서울지역은 02번호
                if let regex = try? NSRegularExpression(pattern: "([0-9]{2})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                }
            } else if prefix == "15" || prefix == "16" || prefix == "18" { // 썩을 지능망...
                if let regex = try? NSRegularExpression(pattern: "([0-9]{4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2")
                    return modString
                }
            } else { // 나머지는 휴대폰번호 (010-xxxx-xxxx, 031-xxx-xxxx, 061-xxxx-xxxx 식이라 상관무)
                if let regex = try? NSRegularExpression(pattern: "([0-9]{3})([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                    let modString = regex.stringByReplacingMatches(in: _str, options: [], range: NSRange(_str.startIndex..., in: _str), withTemplate: "$1-$2-$3")
                    return modString
                }
            }
        }
        return self
    }
    
    /**
     주어진 폭과 폰트에 대한 제약 조건을 고려하여 문자열의 높이를 계산합니다.
     - Parameters:
     - width: 문자열이 표시될 폭
     - font: 문자열의 폰트
     - Returns: 문자열의 높이
     */
    public func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
    
    /**
     레이블의 넓이줌
     - Returns: 문자열의 넓이
     */
    public func labelWidth(font: UIFont) -> CGFloat {
        let nsString = self as NSString
        let width = nsString.size(withAttributes: [.font: font]).width
        return width
    }
    
    
    /**
     문자열에 취소선을 적용한 NSAttributedString을 반환합니다.
     - Returns: 취소선이 적용된 NSAttributedString
     */
    public func strikeThrough() -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                     value: NSUnderlineStyle.single.rawValue,
                                     range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
}

//MARK: -- Subscript
extension String {
    public subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    public subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start..<end]
    }
    
    public subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < start { return "" }
        return self[start...end]
    }
    
    public subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        if end < start { return "" }
        return self[start...end]
    }
    
    public subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex...end]
    }
    
    public subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        if end < startIndex { return "" }
        return self[startIndex..<end]
    }
}

extension String {
    
    /**
     숫자만 필터링된 문자열을 반환합니다.
     - Returns: 숫자만 포함된 문자열
     */
    public var decimalFilteredString: String {
        return String(unicodeScalars.filter(CharacterSet.decimalDigits.contains))
    }
    
    /**
     지정된 패턴에 맞게 문자열을 포맷팅합니다.
     - Parameters:
     - patternString: 패턴 문자열. 숫자 자리는 "#"으로 표시합니다.
     - Returns: 포맷팅된 문자열
     */
    public func formated(by patternString: String) -> String {
        let digit: Character = "#"
        
        let pattern: [Character] = Array(patternString)
        let input: [Character] = Array(self.decimalFilteredString)
        var formatted: [Character] = []
        
        var patternIndex = 0
        var inputIndex = 0
        
        while inputIndex < input.count {
            let inputCharacter = input[inputIndex]
            
            guard patternIndex < pattern.count else { break }
            switch pattern[patternIndex] == digit {
            case true:
                formatted.append(inputCharacter)
                inputIndex += 1
            case false:
                formatted.append(pattern[patternIndex])
            }
            patternIndex += 1
        }
        return String(formatted)
    }
}
