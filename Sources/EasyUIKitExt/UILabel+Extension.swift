//
//  UILabel+Extension.swift
//  bbarge
//
//  Created by 임현규 on 2022/04/25.
//
import UIKit

extension UILabel {
    /**     
     버튼 내 텍스트가 표시될 때 최대로 표시될 수 있는 줄 수를 계산합니다.
     - Returns: 버튼 내 텍스트가 최대로 표시될 수 있는 줄 수를 반환합니다.
     Tag: #Button, #Text
     */
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin,
                                         attributes: [NSAttributedString.Key.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}

extension UILabel {
    /**
     Label의 어트리뷰트 텍스트를 업데이트하기 위한것
     단 "" 이렇게 하면 안됨 최소 공백 하나는 있어야함
     Tag: #Label, #attributedText
     */
    func updateAttString(_ text: String) {
        guard let att = self.attributedText else { return }
        if att.length == 0 { return }
        let attributes = att.attributes(at: 0, effectiveRange: nil)
        self.attributedText = NSMutableAttributedString(string: text, attributes: attributes)
    }
}
